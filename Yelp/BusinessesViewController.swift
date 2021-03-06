//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate,filtersViewControllerDelegate {

    var businesses: [Business]!
    var filteredData: [Business]!
    @IBOutlet weak var tabelView: UITableView!
    var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelView.dataSource = self
        tabelView.delegate   = self
        searchBar            = UISearchBar()
        searchBar.delegate   = self
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        filteredData = businesses
        tabelView.rowHeight  = UITableViewAutomaticDimension
        tabelView.estimatedRowHeight    = 120
        doSearch();
        

/* Example of Yelp search with more search options specified
        Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        }
*/
    }
    
    private func doSearch(){
        var searchTerm = searchBar.text
        if(searchTerm == nil || searchTerm==""){
            searchTerm = "Thai"
        }
        Business.searchWithTerm(searchTerm!, completion: { (businesses: [Business]!, error: NSError!) -> Void in
            print("\(searchTerm)")
            print(NSError)
            self.businesses = businesses
            self.tabelView.reloadData()
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        let navigationViewController = segue.destinationViewController as! UINavigationController
        let filtersViewController    = navigationViewController.topViewController as! FiltersViewController
        filtersViewController.delegate = self
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if businesses != nil{
            return businesses!.count
        }
        return 0
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
        cell.business = businesses[indexPath.row]
        return cell
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar){
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar){
        searchBar.showsCancelButton = false
        searchBar.text              = ""
        searchBar.resignFirstResponder()
    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
        searchBar.resignFirstResponder()
        print(searchBar.text )
        doSearch()
    }
    
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String : AnyObject]) {
        var sort : YelpSortMode!
        var deal : Bool
        if(filters["sort"]!.count > 0) {
            switch(filters["sort"]![0] as! String!){
            case "0":
                sort = YelpSortMode.BestMatched
            case "1":
                sort = YelpSortMode.Distance
            case "2":
                sort = YelpSortMode.HighestRated
            default :
                sort = nil
            }
        }
        if(filters["deals"]!.count > 0){
            deal = true
        }
        else{
            deal = false
        }
        
        print("sort :\(filters["deal"])")
        print("distance \(filters["distance"])")
        let searchCategories = filters["categories"] as! [String]?
        Business.searchWithTerm("Restaurants", sort: sort , categories: searchCategories, deals: deal) { (businesses :[Business]!, error : NSError!) -> Void in
            self.businesses = businesses
            self.tabelView.reloadData()
    
        }
    }

}

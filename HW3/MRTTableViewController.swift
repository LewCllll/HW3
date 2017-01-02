//
//  TableViewController.swift
//  HW3
//
//  Created by Llewellyn Cheung on 2/1/2017.
//  Copyright © 2017 Llewellyn Cheung. All rights reserved.
//

import UIKit
import ObjectMapper

struct MRT {
    let lines: [Line]
}

struct Line{
    let name: String
    let stations: [Station]
}

struct Station {
    var name: String!
    var lines: [String : String]!
}

extension Station: Mappable {
    init?(map: Map) {}
    mutating func mapping(map: Map){
        self.name <- map["name"]
        self.lines <- map["lines"]
    }
}

class StationTableViewCell: UITableViewCell {
    @IBOutlet weak var StationCodeLabel: UILabel!
}

class MRTTableViewController: UITableViewController {
    var linesSet = [Line]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stationJSONPath = Bundle.main.path(forResource: "MRT", ofType: "json")!
        let stationJSON = try! String(contentsOfFile: stationJSONPath)
        let stationsDict : [Station] = Mapper<Station>().mapArray(JSONString: stationJSON)!
        
        var dictOfLinesAndStations = [String: [Station]]()
        
        for stationCount in 1 ..< stationsDict.count {
            let MRTStations = stationsDict[stationCount].lines
            for (line, station) in MRTStations! {
                if dictOfLinesAndStations[line] == nil {
                    dictOfLinesAndStations[line] = []
                }
                dictOfLinesAndStations[line]!.append(stationsDict[stationCount])
            }
        }
        
        for (lineName, stations) in dictOfLinesAndStations {
            let sortedStations = stations.sorted(by: { (station1: Station, station2: Station) -> Bool in
                return station1.lines[lineName]! < station2.lines[lineName]!
            })
            
            let line = Line(name: lineName, stations: sortedStations)
            linesSet.append(line)
        }
        
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return linesSet.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return linesSet[section].stations.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.linesSet[section].name
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StationCell", for: indexPath) as! StationTableViewCell
        
        let station = linesSet[indexPath.section].stations[indexPath.row]
        for (lineName, stations) in station.lines {
            cell.StationCodeLabel?.text = station.lines![lineName]
        }
        cell.textLabel?.text = station.name
        return cell
    }
    
    
    
        
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            guard let detailViewController = segue.destination as? StationDetailViewController else {
                return
            }
            
            guard let cell = sender as? UITableViewCell else {
                return
            }
            let indexPath = self.tableView.indexPath(for: cell)!
            
            // Get airport object from the index path
            let station = linesSet[indexPath.section].stations[indexPath.row]
            // Tell the detail view controller which airport to show
            detailViewController.station = station
        } else {
            // Ask the super class to handle segues we don't know
            super.prepare(for: segue, sender: sender)
        }
    }




}

//
//  StationDetailViewController.swift
//  HW3
//
//  Created by Llewellyn Cheung on 2/1/2017.
//  Copyright © 2017 Llewellyn Cheung. All rights reserved.
//

import UIKit

class StationDetailViewController: UIViewController {

    @IBOutlet weak var StationLabel: UILabel!
    @IBOutlet weak var LineLabel: UILabel!
    @IBOutlet weak var LineLabel2: UILabel!

    
    var station: Station? {
        didSet {
            // Update when the model is changed.
            self.updateLabels()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateLabels()
    }
    
    func updateLabels() {
        guard self.isViewLoaded else {
            return
        }
        
        self.navigationItem.title = self.station?.name
        self.StationLabel.text = self.station?.name
        //Line Label
        var lineArray = [String]()
        for (line, stationCode) in (self.station?.lines)!{
            lineArray.append("\(line)")
            
            self.LineLabel.text = lineArray[0]
            print (lineArray)
            
            switch lineArray[0] {
            case "淡水信義線" :
                self.LineLabel.backgroundColor = UIColor(red: 203/255, green: 44/255, blue: 48/255, alpha: 1)
            case "松山新店線" :
                self.LineLabel.backgroundColor = UIColor(red: 0/255, green: 119/255, blue: 73/255, alpha: 1)
            case "中和新蘆線" :
                self.LineLabel.backgroundColor = UIColor(red: 255/255, green: 163/255, blue: 0/255, alpha: 1)
            case "文湖線" :
                self.LineLabel.backgroundColor = UIColor(red: 158/255, green: 101/255, blue: 46/255, alpha: 1)
            case "板南線" :
                self.LineLabel.backgroundColor = UIColor(red: 0/255, green: 94/255, blue: 184/255, alpha: 1)
            case "新北投支線" :
                self.LineLabel.backgroundColor = UIColor(red: 248/255, green: 144/255, blue: 165/255, alpha: 1)
            case "小碧潭支線" :
                self.LineLabel.backgroundColor = UIColor(red: 206/255, green: 220/255, blue: 0/255, alpha: 1)
            case "貓空纜車" :
                self.LineLabel.backgroundColor = UIColor(red: 119/255, green: 185/255, blue: 51/255, alpha: 1)
            default:
                self.LineLabel.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
            }
            
            if lineArray.count > 1 {
                self.LineLabel2.text = lineArray[1]
                switch lineArray[1] {
                case "淡水信義線" :
                    self.LineLabel2.backgroundColor = UIColor(red: 203/255, green: 44/255, blue: 48/255, alpha: 1)
                case "松山新店線" :
                    self.LineLabel2.backgroundColor = UIColor(red: 0/255, green: 119/255, blue: 73/255, alpha: 1)
                case "中和新蘆線" :
                    self.LineLabel2.backgroundColor = UIColor(red: 255/255, green: 163/255, blue: 0/255, alpha: 1)
                case "文湖線" :
                    self.LineLabel2.backgroundColor = UIColor(red: 158/255, green: 101/255, blue: 46/255, alpha: 1)
                case "板南線" :
                    self.LineLabel2.backgroundColor = UIColor(red: 0/255, green: 94/255, blue: 184/255, alpha: 1)
                case "新北投支線" :
                    self.LineLabel2.backgroundColor = UIColor(red: 248/255, green: 144/255, blue: 165/255, alpha: 1)
                case "小碧潭支線" :
                    self.LineLabel2.backgroundColor = UIColor(red: 206/255, green: 220/255, blue: 0/255, alpha: 1)
                case "貓空纜車" :
                    self.LineLabel2.backgroundColor = UIColor(red: 119/255, green: 185/255, blue: 51/255, alpha: 1)
                default:
                    self.LineLabel2.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
                }
                
            }

        }

    }




}

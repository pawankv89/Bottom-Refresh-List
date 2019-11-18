# Bottom-Refresh-List

## Bottom Refresh List when scroll down then get response by API.


Added Some screens here.

![](https://github.com/pawankv89/Bottom-Refresh-List/blob/master/images/screen_1.png)
![](https://github.com/pawankv89/Bottom-Refresh-List/blob/master/images/screen_2.png)
![](https://github.com/pawankv89/Bottom-Refresh-List/blob/master/images/screen_3.png)

## Usage

#### Controller

``` swift 

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    //Refresh Control
    private let refreshControl = UIRefreshControl()
    
    private var refreshBottomView: UIView!
    
    private var refreshBottomEnable: Bool!
    
    var contacts: Array <Any> = Array <Any>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.contacts = ["Hello","Hi"]
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.reloadData()
        
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshBeforeDataUIController(_:)), for: .valueChanged)
        
        // Configure Bottom Refresh Control
        self.refreshBottomEnable = true
        
    }
    
    
    func refreshBottomUIController( isShow: Bool) {
           
    // Configure Bottom Refresh Control
        if isShow == true {

             let frame: CGRect = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 50)
             let footerView: UIView = UIView.init(frame: frame)
             let activity = UIActivityIndicatorView.init(style: .gray)
             activity.startAnimating()
             footerView.addSubview(activity)
             activity.center = footerView.center
             self.refreshBottomView = footerView
             
            self.refreshBottomEnable = false
            self.tableView.tableFooterView = self.refreshBottomView
            
        } else {
            
             self.refreshBottomEnable = true
             self.tableView.tableFooterView = nil
        }
    }
    
    @objc private func refreshBeforeDataUIController(_ sender: Any) {
        
        //Called API
    }
    
    @objc private func refreshAfterDataUIController() {
        
        //Calling End of API Response
        
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height
        if (endScrolling >= scrollView.contentSize.height) {
            
            if self.refreshBottomEnable ==  true {
                
                print("Scroll End Calling")
                 refreshBottomUIController( isShow: true)
                
                //API Request
                loadListData()
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return contacts.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellIdentifier: String = "ContactAddressBookCell"
        var cell : ContactAddressBookCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? ContactAddressBookCell
        if (cell == nil)
        {
            var nib:Array = Bundle.main.loadNibNamed("ContactAddressBookCell", owner: self, options: nil)!
            cell = nib[0] as? ContactAddressBookCell
        }
        
        let contactItem = contacts[indexPath.row]
            
        //Set Text
        cell?.titleLabel.text? = contactItem as! String
        
        //Cell Selection
        cell?.selectionStyle = .none
        
        return cell!
    }
    
    
    func loadListData() -> () {
        
       DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
           
        self.contacts.append("Refresh Added")
            
        self.refreshBottomUIController( isShow: false)
        
        self.tableView.reloadData()
       
        }
        
    }
}



```


## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).

## Change-log

A brief summary of each this release can be found in the [CHANGELOG](CHANGELOG.mdown). 


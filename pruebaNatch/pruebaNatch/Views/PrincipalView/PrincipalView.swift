//
//  PrincipalView.swift
//  pruebaNatch
//
//  Created by Angel Olvera on 21/06/21.
//

import UIKit

class PrincipalView: UIViewController {

    @IBOutlet weak var tableview: UITableView!{
        didSet{
            tableview.register(UINib(nibName: NameCell.identifier, bundle: nil), forCellReuseIdentifier: NameCell.identifier)
            tableview.register(UINib(nibName: PhotoCell.identifier, bundle: nil), forCellReuseIdentifier: PhotoCell.identifier)
            tableview.register(UINib(nibName: GraphCell.identifier, bundle: nil), forCellReuseIdentifier: GraphCell.identifier)
            tableview.delegate = self
            tableview.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension PrincipalView: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: NameCell.identifier, for: indexPath) as! NameCell
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCell.identifier, for: indexPath) as! PhotoCell
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: GraphCell.identifier, for: indexPath) as! GraphCell
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint(indexPath.row)
        if indexPath.row == 1{
            let vc = Popup()
            navigationController?.pushViewController(vc, animated: false)
        }
    }
}

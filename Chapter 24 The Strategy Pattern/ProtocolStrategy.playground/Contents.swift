import Foundation
import UIKit

class DataSourceStrategy: NSObject, UITableViewDataSource {

    let data: [CustomStringConvertible]

    init(_ data: CustomStringConvertible...) {
        self.data = data
    }

    func tableView(_: UITableView,
                   numberOfRowsInSection _: Int) -> Int
    {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell()
        cell.textLabel?.text = data[indexPath.row].description
        return cell
    }
}

let dataSource = DataSourceStrategy("London", "New York", "Paris", "Rome")
let table = UITableView(frame: CGRect(origin: .zero, size: CGSize(width: 400, height: 200)))
table.dataSource = dataSource
table.reloadData()

// required for display in assistant editor
table

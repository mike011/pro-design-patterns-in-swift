import UIKit

class ProductTableCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var stockStepper: UIStepper!
    @IBOutlet var stockField: UITextField!

    var product: Product?
}

var handler = { (p: Product) in
    println("Change: \(p.name) \(p.stockLevel) items in stock")
}

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet var totalStockLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    var productStore = ProductDataStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        displayStockTotal()

        productStore.callback = { (p: Product) in
            for cell in self.tableView.visibleCells() {
                if let pcell = cell as? ProductTableCell {
                    if pcell.product?.name == p.name {
                        pcell.stockStepper.value = Double(p.stockLevel)
                        pcell.stockField.text = String(p.stockLevel)
                    }
                }
            }
            self.displayStockTotal()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(tableView _: UITableView,
                   numberOfRowsInSection _: Int) -> Int
    {
        return productStore.products.count
    }

    func tableView(tableView: UITableView,
                   cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let product = productStore.products[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("ProductCell")
            as ProductTableCell
        cell.product = productStore.products[indexPath.row]
        cell.nameLabel.text = product.name
        cell.descriptionLabel.text = product.productDescription
        cell.stockStepper.value = Double(product.stockLevel)
        cell.stockField.text = String(product.stockLevel)
        return cell
    }

    @IBAction func stockLevelDidChange(sender: AnyObject) {
        if var currentCell = sender as? UIView {
            while true {
                currentCell = currentCell.superview!
                if let cell = currentCell as? ProductTableCell {
                    if let product = cell.product? {
                        if let stepper = sender as? UIStepper {
                            product.stockLevel = Int(stepper.value)
                        } else if let textfield = sender as? UITextField {
                            if let newValue = textfield.text.toInt()? {
                                product.stockLevel = newValue
                            }
                        }
                        cell.stockStepper.value = Double(product.stockLevel)
                        cell.stockField.text = String(product.stockLevel)
                        productLogger.logItem(product)
                    }
                    break
                }
            }
            displayStockTotal()
        }
    }

    func displayStockTotal() {
        let finalTotals: (Int, Double) = productStore.products.reduce((0, 0.0)) { (totals, product) -> (Int, Double) in
            (
                totals.0 + product.stockLevel,
                totals.1 + product.stockValue
            )
        }

        var factory = StockTotalFactory.getFactory(StockTotalFactory.Currency.GBP)
        var totalAmount = factory.converter?.convertTotal(finalTotals.1)
        var formatted = factory.formatter?.formatTotal(totalAmount!)

        totalStockLabel.text = "\(finalTotals.0) Products in Stock. "
            + "Total Value: \(formatted!)"
    }
}

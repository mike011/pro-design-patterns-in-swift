import UIKit

class ProductTableCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var stockStepper: UIStepper!
    @IBOutlet var stockField: UITextField!

    var product: Product?
}

var handler = { (p: Product) in
    print("Change: \(p.name) \(p.stockLevel) items in stock")
}

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet var totalStockLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    var productStore = ProductDataStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        displayStockTotal()
        let bridge = EventBridge(callback: updateStockLevel)
        productStore.callback = bridge.inputCallback
    }

    func updateStockLevel(name: String, level: Int) {
        for cell in tableView.visibleCells {
            if let pcell = cell as? ProductTableCell {
                if pcell.product?.name == name {
                    pcell.stockStepper.value = Double(level)
                    pcell.stockField.text = String(level)
                }
            }
        }
        displayStockTotal()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_: UITableView,
                   numberOfRowsInSection _: Int) -> Int
    {
        return productStore.products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = productStore.products[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell")
        as! ProductTableCell
        cell.product = productStore.products[indexPath.row]
        cell.nameLabel.text = product.name
        cell.descriptionLabel.text = product.productDescription
        cell.stockStepper.value = Double(product.stockLevel)
        cell.stockField.text = String(product.stockLevel)

        CellFormatter.createChain().formatCell(cell: cell)
        return cell
    }

    @IBAction func stockLevelDidChange(sender: AnyObject) {
        if var currentCell = sender as? UIView {
            while true {
                currentCell = currentCell.superview!
                if let cell = currentCell as? ProductTableCell {
                    if let product = cell.product {
                        if let stepper = sender as? UIStepper {
                            product.stockLevel = Int(stepper.value)
                        } else if let textfield = sender as? UITextField {
                            if let string = textfield.text {
                                product.stockLevel = Int(string) ?? 0
                            }
                        }
                        cell.stockStepper.value = Double(product.stockLevel)
                        cell.stockField.text = String(product.stockLevel)
                        productLogger.logItem(item: product)

                        StockServerFactory.getStockServer()
                            .setStockLevel(product: product.name, stockLevel: product.stockLevel)
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

        let formatted = StockTotalFacade.formatCurrencyAmount(amount: finalTotals.1,
                                                              currency: StockTotalFacade.Currency.EUR)

        totalStockLabel.text = "\(finalTotals.0) Products in Stock. "
            + "Total Value: \(formatted!)"
    }
}

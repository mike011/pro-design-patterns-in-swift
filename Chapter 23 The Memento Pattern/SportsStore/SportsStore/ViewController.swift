import UIKit

class ProductTableCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var stockStepper: UIStepper!
    @IBOutlet var stockField: UITextField!

    var product: Product?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let selector = #selector(handleStockLevelUpdate(_:))
        let name = NSNotification.Name(rawValue: "stockUpdate")
        NotificationCenter.default.addObserver(self,
                                               selector: selector,
                                               name: name,
                                               object: nil)
    }

    @objc func handleStockLevelUpdate(_ notification: NSNotification) {
        guard let updatedProduct = notification.object as? Product else {
            return
        }
        if updatedProduct.name == product?.name {
            DispatchQueue.main.async {
                self.stockStepper.value = Double(updatedProduct.stockLevel)
                self.stockField.text = String(updatedProduct.stockLevel)
            }
        }
    }
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

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEvent.EventSubtype.motionShake {
            print("Shake motion detected")
            undoManager?.undo()
        }
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

                        undoManager?.registerUndo(withTarget: self,
                                                  selector: #selector(resetState),
                                                  object: nil)

                        if let stepper = sender as? UIStepper {
                            product.stockLevel = Int(stepper.value)
                        } else if let textfield = sender as? UITextField {
                            if let text = textfield.text, let newValue = Int(text) {
                                product.stockLevel = newValue
                            }
                        }
//                        cell.stockStepper.value = Double(product.stockLevel);
//                        cell.stockField.text = String(product.stockLevel);
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

    @objc func resetState() {
        productStore.resetState()
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

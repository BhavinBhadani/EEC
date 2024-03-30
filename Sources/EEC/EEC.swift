import ArgumentParser
import Models
import Modules
import Utils

@main
struct EEC: ParsableCommand {
    
    static let configuration = CommandConfiguration(commandName: "eec", abstract: "Command line tool")
    
    @Flag(name: .long, help: "Calculate delivery cost")
    var calculateDeliveryCost: Bool = false

    @Flag(name: .long, help: "Calculate Delivery time")
    var calulateDeliveryTime: Bool = false

    @Flag(name: .long, help: "Get all existing offercodes")
    var getAllOfferCodes: Bool = false

    @Flag(name: .long, help: "Add new offercode")
    var addNewOfferCode: Bool = false

    mutating func run() throws {
        print("Everest Engineering".yellow)
        if calculateDeliveryCost {
            print("Calculating delivery cost...".blue)
            PackageDeliveryDiscount.getDeliveryPriceDiscount()
        } else if calulateDeliveryTime {
            print("Calculating delivery time...".blue)
            PackageDeliveryTimeWrapper.getAllPackageDeliveryTime()
        } else if getAllOfferCodes {
            print("Getting all existing offer codes...".blue)
            GetOffers.allOfferCodes()
        } else if addNewOfferCode {
            print("Adding new offer code...".blue)
            AddOffer.getNewOfferDetails()
        } else {
            Self.helpMessage()
        }
    }
    
    // Help message
    static func helpMessage() {
        print("Usage: ecc [option]")
        print("Options:")
        print("  --calculate-delivery-cost: Calculate delivery cost")
        print("  --calulate-delivery-time: Calculate delivery time")
        print("  --get-all-offer-codes: Get all existing offercodes")
        print("  --add-new-offer-code: Add new offercode")
        print("  -h, --help: Show help information.")
    }
}

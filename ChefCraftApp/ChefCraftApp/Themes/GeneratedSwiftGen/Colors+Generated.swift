// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum AppColors {
  internal static let aquaMarine = ColorAsset(name: "aquaMarine")
  internal static let aquaMarine50 = ColorAsset(name: "aquaMarine50")
  internal static let bgCream = ColorAsset(name: "bgCream")
  internal static let black = ColorAsset(name: "black")
  internal static let black25 = ColorAsset(name: "black25")
  internal static let black40 = ColorAsset(name: "black40")
  internal static let black60 = ColorAsset(name: "black60")
  internal static let brightSkyBlue = ColorAsset(name: "brightSkyBlue")
  internal static let cream = ColorAsset(name: "cream")
  internal static let darkBlueGrey = ColorAsset(name: "darkBlueGrey")
  internal static let darkIndigo = ColorAsset(name: "darkIndigo")
  internal static let disabledCream = ColorAsset(name: "disabledCream")
  internal static let errorOrange = ColorAsset(name: "errorOrange")
  internal static let essentialRed = ColorAsset(name: "essentialRed")
  internal static let frenchGrey = ColorAsset(name: "frenchGrey")
  internal static let green = ColorAsset(name: "green")
  internal static let grey1 = ColorAsset(name: "grey1")
  internal static let grey2 = ColorAsset(name: "grey2")
  internal static let grey3 = ColorAsset(name: "grey3")
  internal static let issueAcne = ColorAsset(name: "issueAcne")
  internal static let issueDarkCircle = ColorAsset(name: "issueDarkCircle")
  internal static let issueEyeBag = ColorAsset(name: "issueEyeBag")
  internal static let issueGlow = ColorAsset(name: "issueGlow")
  internal static let issueHygiene = ColorAsset(name: "issueHygiene")
  internal static let issueMassage = ColorAsset(name: "issueMassage")
  internal static let issueOilySkin = ColorAsset(name: "issueOilySkin")
  internal static let issueTexture = ColorAsset(name: "issueTexture")
  internal static let issueToning = ColorAsset(name: "issueToning")
  internal static let issueWrinkles = ColorAsset(name: "issueWrinkles")
  internal static let lightCream = ColorAsset(name: "lightCream")
  internal static let mediumCream = ColorAsset(name: "mediumCream")
  internal static let orange = ColorAsset(name: "orange")
  internal static let palelilac = ColorAsset(name: "palelilac")
  internal static let primaryGreen = ColorAsset(name: "primaryGreen")
  internal static let primaryPurple = ColorAsset(name: "primaryPurple")
  internal static let primaryWhite = ColorAsset(name: "primaryWhite")
  internal static let purple = ColorAsset(name: "purple")
  internal static let secondaryGrey1 = ColorAsset(name: "secondaryGrey1")
  internal static let secondaryGrey2 = ColorAsset(name: "secondaryGrey2")
  internal static let secondaryGrey3 = ColorAsset(name: "secondaryGrey3")
  internal static let steel = ColorAsset(name: "steel")
  internal static let turquoise = ColorAsset(name: "turquoise")
  internal static let white0 = ColorAsset(name: "white0")
  internal static let white60 = ColorAsset(name: "white60")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type

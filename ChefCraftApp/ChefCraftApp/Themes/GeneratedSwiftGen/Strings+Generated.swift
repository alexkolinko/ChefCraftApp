// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum AppStrings {

  internal enum Favorites {
    internal enum Data {
      internal enum Empty {
        /// Recipes is empty
        internal static var title: String { return AppStrings.tr("Localizable", "favorites.data.empty.title") }
      }
    }
    internal enum Navigation {
      /// Your favorites recipes
      internal static var title: String { return AppStrings.tr("Localizable", "favorites.navigation.title") }
    }
  }

  internal enum Localization {
    internal enum Language {
      internal enum Enum {
        /// Ukranian
        internal static var ukranian: String { return AppStrings.tr("Localizable", "localization.language.enum.ukranian") }
      }
    }
  }

  internal enum Recipe {
    /// by: 
    internal static var chef: String { return AppStrings.tr("Localizable", "recipe.chef") }
  }

  internal enum TabBar {
    internal enum Favorites {
      internal enum Item {
        /// Favorites
        internal static var title: String { return AppStrings.tr("Localizable", "tabBar.favorites.item.title") }
      }
    }
    internal enum Home {
      internal enum Item {
        /// Home
        internal static var title: String { return AppStrings.tr("Localizable", "tabBar.home.item.title") }
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension AppStrings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    return String(format: key.localized, arguments: args)
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


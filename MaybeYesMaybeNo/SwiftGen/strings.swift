// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  /// Delete
  internal static let deleteRowAction = L10n.tr("Localizable", "deleteRowAction")

  internal enum AlertController {
    /// Please fill in the field
    internal static let message = L10n.tr("Localizable", "alertController.message")
    /// New Answer
    internal static let title = L10n.tr("Localizable", "alertController.title")
    internal enum Action {
      /// Cancel
      internal static let cancel = L10n.tr("Localizable", "alertController.action.cancel")
      /// Save
      internal static let save = L10n.tr("Localizable", "alertController.action.save")
    }
    internal enum TextField {
      /// New Answer
      internal static let placeholder = L10n.tr("Localizable", "alertController.textField.placeholder")
    }
  }

  internal enum Application {
    internal enum Bundle {
      /// MaybeYesMaybeNo
      internal static let name = L10n.tr("Localizable", "application.bundle.name")
    }
  }

  internal enum BarButtonItem {
    /// Add
    internal static let add = L10n.tr("Localizable", "barButtonItem.add")
  }

  internal enum Cell {
    /// Cell
    internal static let identifier = L10n.tr("Localizable", "cell.identifier")
  }

  internal enum DefaultAnswer {
    /// 
    internal static let type = L10n.tr("Localizable", "defaultAnswer.type")
  }

  internal enum Image {
    /// settings
    internal static let settingsButton = L10n.tr("Localizable", "image.settingsButton")
  }

  internal enum Link {
    /// question
    internal static let path = L10n.tr("Localizable", "link.path")
    /// https://8ball.delegator.com/magic/JSON/
    internal static let url = L10n.tr("Localizable", "link.url")
  }

  internal enum Screen {
    /// SettingsView
    internal static let settingsView = L10n.tr("Localizable", "screen.settingsView")
  }

  internal enum Storyboard {
    /// Main
    internal static let main = L10n.tr("Localizable", "storyboard.main")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}

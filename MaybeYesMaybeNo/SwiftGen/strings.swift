// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {

  internal enum RowAction {
    /// Delete
    internal static let delete = L10n.tr("Localizable", "RowAction.delete")
  }

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
    internal enum Title {
      /// Add
      internal static let add = L10n.tr("Localizable", "barButtonItem.title.add")
    }
  }

  internal enum DefaultAnswer {
    /// 
    internal static let type = L10n.tr("Localizable", "defaultAnswer.type")
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
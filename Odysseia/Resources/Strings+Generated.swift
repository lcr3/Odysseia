// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
    internal enum LaunchScreen {
    }
    internal enum Localizable {
        /// 追加
        internal static let addButtonText = L10n.tr("Localizable", "addButtonText")
        /// データの追加に失敗しました
        internal static let addGoalErrorMessage = L10n.tr("Localizable", "AddGoalErrorMessage")
        /// データの削除に失敗しました
        internal static let deleteGoalErrorMessage = L10n.tr("Localizable", "DeleteGoalErrorMessage")
        /// 完了
        internal static let doneButtonText = L10n.tr("Localizable", "doneButtonText")
        /// 編集
        internal static let editButtonText = L10n.tr("Localizable", "editButtonText")
        /// データの編集に失敗しました
        internal static let editGoalErrorMessage = L10n.tr("Localizable", "EditGoalErrorMessage")
        /// データの取得に失敗しました
        internal static let getGoalErrorMessage = L10n.tr("Localizable", "GetGoalErrorMessage")
        /// データの更新に失敗しました
        internal static let updateGoalErrorMessage = L10n.tr("Localizable", "UpdateGoalErrorMessage")
    }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
    private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
        let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
        return String(format: format, locale: Locale.current, arguments: args)
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

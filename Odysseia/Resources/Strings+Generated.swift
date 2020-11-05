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
        internal static let addGoalErrorMsg = L10n.tr("Localizable", "AddGoalErrorMsg")
        /// 数値目標を削除しますか？
        internal static let addTaskDeleteMsg = L10n.tr("Localizable", "AddTaskDeleteMsg")
        /// 数値目標を設定してください
        internal static let addTaskNilMsg = L10n.tr("Localizable", "AddTaskNilMsg")
        /// 数値目標の達成したい回数を入力してください
        internal static let addTaskTargetLevelNilMsg = L10n.tr("Localizable", "AddTaskTargetLevelNilMsg")
        /// 数値目標のタイトルを入力してください
        internal static let addTaskTitleNilMsg = L10n.tr("Localizable", "AddTaskTitleNilMsg")
        /// キャンセル
        internal static let cancel = L10n.tr("Localizable", "Cancel")
        /// 目標締め切り年度を設定してください
        internal static let deadlineYearNilMsg = L10n.tr("Localizable", "DeadlineYearNilMsg")
        /// 目標締め切り年度が不正です
        internal static let deadlineYearUnknownMsg = L10n.tr("Localizable", "DeadlineYearUnknownMsg")
        /// 削除
        internal static let delete = L10n.tr("Localizable", "Delete")
        /// データの削除に失敗しました
        internal static let deleteGoalErrorMsg = L10n.tr("Localizable", "DeleteGoalErrorMsg")
        /// 完了
        internal static let doneButtonText = L10n.tr("Localizable", "doneButtonText")
        /// 編集
        internal static let editButtonText = L10n.tr("Localizable", "editButtonText")
        /// データの編集に失敗しました
        internal static let editGoalErrorMsg = L10n.tr("Localizable", "EditGoalErrorMsg")
        /// データの取得に失敗しました
        internal static let getGoalErrorMsg = L10n.tr("Localizable", "GetGoalErrorMsg")
        /// 目標を入力して下さい
        internal static let goalTitleNilMsg = L10n.tr("Localizable", "GoalTitleNilMsg")
        /// OK
        internal static let ok = L10n.tr("Localizable", "Ok")
        /// データの更新に失敗しました
        internal static let updateGoalErrorMsg = L10n.tr("Localizable", "UpdateGoalErrorMsg")
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

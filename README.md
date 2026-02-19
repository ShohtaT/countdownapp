# Countdown App

SwiftUI + SwiftData をベースに、クリーンアーキテクチャ + DDD で構築したカウントダウンアプリ。

## 機能

- イベントごとのカウントダウン表示（日・時間・分・秒をリアルタイム更新）
- スワイプでイベント切り替え（TabView ページスタイル）
- イベントの追加・編集・削除
- 8色のプリセットカラーから選択
- 一覧画面で「アクティブ」「期限切れ」をセクション分離表示

## 必要環境

- Xcode 16.4 以降
- iOS 18.0 以降

## アーキテクチャ

```
View → ViewModel → UseCase → Repository(Protocol) → Repository(Impl) → SwiftData
```

### プロジェクト構造

```
countdownapp/
├── Domain/                  # ドメイン層（ビジネスルール）
│   ├── Entities/            #   CountdownEvent（エンティティ）
│   ├── ValueObjects/        #   TimeRemaining, EventColor（値オブジェクト）
│   └── Repositories/        #   リポジトリプロトコル
│
├── Data/                    # データ層（永続化）
│   ├── Models/              #   SwiftData モデル
│   ├── Repositories/        #   リポジトリ実装
│   └── Mappers/             #   ドメイン ↔ モデル変換
│
├── Application/             # アプリケーション層（ユースケース）
│   └── UseCases/            #   Add / Delete / Fetch / Update
│
├── Presentation/            # プレゼンテーション層（UI）
│   ├── ViewModels/          #   @Observable ViewModel
│   ├── Views/               #   SwiftUI View
│   └── Components/          #   再利用可能な UI コンポーネント
│
├── ContentView.swift        # DI ラッパー
└── countdownappApp.swift    # アプリエントリポイント
```

## 画面構成

| 画面 | 説明 |
|------|------|
| CountdownPageView | メイン画面。スワイプでイベント切り替え |
| CountdownCardView | 1 イベント分のフルスクリーンカード |
| CountdownTimerView | 日・時間・分・秒のタイマーパネル表示 |
| EventFormSheet | イベント追加・編集シート |
| EventListView | 一覧（アクティブ / 期限切れセクション） |
| EmptyStateView | イベント未登録時の案内 |

## ドメインモデル

### CountdownEvent

| プロパティ | 型 | 説明 |
|-----------|-----|------|
| id | UUID | 一意識別子 |
| title | String | イベント名 |
| targetDate | Date | ターゲット日時 |
| color | EventColor | カラー（8色プリセット） |
| createdAt | Date | 作成日時 |
| displayOrder | Int | 表示順 |

### EventColor

`blue` / `purple` / `pink` / `red` / `orange` / `green` / `teal` / `indigo`

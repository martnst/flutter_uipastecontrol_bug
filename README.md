# Bug Reproducer UIPasteControl

This project demos a bug in Flutter using [UIPasteContorl](https://developer.apple.com/documentation/uikit/uipastecontrol) via [a native iOS view](https://docs.flutter.dev/platform-integration/ios/platform-views).

When setting a `CupertinoThemeData` with `barBackgroundColor` the app will prompt the user for consent of reading the clipboard upon tapping on the `UIPasteContorl`. However the control is actually supposed to paste without asking the user.

> "Use this class to paste without a user prompt"
>
> https://developer.apple.com/documentation/uikit/uipastecontrol

Please see the included screencast to understand the problem:
`screenshots/Screen%20Recording%202023-05-02%20at%2018.50.37.mov`

## Screenshots

![](screenshots/Simulator%20Screenshot%20-%20iPhone%2014%20-%201.png)
![](screenshots/Simulator%20Screenshot%20-%20iPhone%2014%20-%202.png)

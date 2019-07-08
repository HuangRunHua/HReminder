# HReminder
HReminder is a Cocoa Touch framework and manages label displayed at the top of the screen. It is especially well suited as a small tag to remind users about something.

It has an interface similar to the label displayed by Medium which Medium app uses this label to reminder reader to 'Start from beginning'. It now only support iPhone, and not perform well in iPad.

Here are some screenshots showing what you can build with HReminder.
![example photo](https://github.com/HuangRunHua/HReminder/blob/master/IMG_C6F2E1A6B76F-1.jpeg)

## Requirements
- Xcode 11 and later
- iOS 13 and later
- Swift 5.0 and later
- Device Orientation: Portrait

## Installation
You can only clone this framework and add it to your project🤪

## Usage
It's very simple to use this framwork, just a few steps.
### The Basics
HReminder displays a Button called `reminderButton`, specially it is not a `Label`. This framework provides a standard type called `HReminderViewController`. I have provided several interfaces that allow you to modify the color of the button and the title of the button. You can also choose your actions after clicking the button.

### Displaying Button
To display this button you first need to create a HReminderViewController.
```swift
var reminder = HReminderViewController()
```
To present your button, call this method:
```swift
self.reminder.showInView(superview: self.view)
```
If you want to hide this button, call this method:
``` swift
self.reminder.hideInView()
```
There is also an another way to hide this button by calling `ReminderViewClose()`.(I will explain later)

### Change Title and Color
You can simply change the title and color of the button by calling these two methods:
```swift
self.reminder.setTitle(Reminder: "Start from beginning")
self.reminder.setReminderBackgroundColor(color: .systemGreen)
```

### Handling Button Taps
If you want to play some actions after tapping the button you can simply add `HReminderViewControllerDelegate` to your project. Set `HReminderViewControllerDelegate` to be your superclass. 

And then add codes to your `viewDidLoad()` :
```swift
reminder.delegate = self
```

Now I provide a method for you to handle button taps. You can write your actions in `ReminderViewClose()`, simply like:
```swift
func ReminderViewClose() {
        let alertController = UIAlertController(title: "Attention", message: "You have tapped the button", preferredStyle: .alert)
        let cancleAction = UIAlertAction(title: "Cancle", style: .cancel, handler: nil)
        alertController.addAction(cancleAction)
        present(alertController, animated: true, completion: nil)
}
```

## Last but not least
I will add more features to this framework.🤗








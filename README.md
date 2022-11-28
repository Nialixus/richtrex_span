# RichTrex: Span
<a href='https://pub.dev/packages/richtrex_span'><img src='https://img.shields.io/pub/v/richtrex_span.svg?logo=flutter&color=blue&style=flat-square'/></a>\
\
An extended package of `RichTrex` package which is used to encode list of `TextSpan` into `String`, and decode `String` into list of `TextSpan`.

## Preview
<table>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/45191605/175512465-5025e618-99c5-4638-99d6-709e5fafb569.png"/></td>
    <td><img src="https://user-images.githubusercontent.com/45191605/175517176-bd5041a8-c1ec-4b04-a4d4-346758875420.png"/></td>
  </tr>
</table>

## Primary Feature

- Font Color ✅
- Font Weight ✅
- Font Size ✅
- Font Family ✅
- Custom ❌
- Italic ✅
- Underline ✅
- Strikethrough ✅
- Background Color ✅
- Image ✅
- Alignment ✅
- Ordered List ❌
- Unordered List ❌
- Block Quote ✅
- Hyperlink ✅

## Secondary Feature

- Superscript ❌
- Subscript ❌
- Shadow ✅
- Vertical Space ✅
- Horizontal Space ✅
- Overline ✅
- Padding ✅
- Table ❌
- Video ❌


## Install

Add this line to your pubspec.yaml.

```yaml
dependencies:
  richtrex_span: ^1.1.0
```

## Usage

First, import the RichTrex: Span package.

```dart
import 'package:richtrex_span/richtrex_span.dart';
```

And to encode, you need to set a list of `RichTrexSpan` just like this.

```dart
const List<RichTrexSpan> span = [
    RichTrexSpan(
        text: "RichTrex: Format",
        fontWeight: FontWeight.bold,
        fontSize: 25,
        align: Alignment.center),
    RichTrexSpan(
        text: "\n This is an Example of using RichTrexFormat.")
  ];

  String result = RichTrex.encode(span);
```

or if you want to decode list of `RichTrexSpan` from `String` you can use this.

```dart
String text =  """<style="font-weight:6;font-size:25.0;align-x:0.0;align-y:0.0;">RichTrex: Format</style>
This is an Example of using RichTrexFormat.""";

List<RichTrexSpan> result = RichTrex.decode(text);
```

and implement the decoded result into `Text.rich` just like this.

```dart
return Text.rich(
          TextSpan(children: RichTrexSpan.decode(text)),
          key: UniqueKey(),
        );
```
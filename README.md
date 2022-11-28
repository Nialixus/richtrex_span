
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
  richtrex_span: ^1.2.0
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

## Codelist

<table>
	<tr>
		<td><b>Definition</b></td>
		<td><b>RichTrexSpan</b></td>
		<td><b>String</b></td>
	</tr>
	<tr>
	<td>Alignment</td>
		<td>
			<code>
				RichTrexSpan(text: "value", align: Alignment.center)
			</code>
		</td>
		<td>
			<code>
				&lt;style="align-x:0.0;align-y:0.0;"&gt;value&lt;/style&gt;
			</code>
		</td>
	</tr>
	<tr>
	<td>Background Color</td>
		<td>
			<code>
				RichTrexSpan(text:"value", backgroundColor: Colors.red)
			</code>
		</td>
		<td>
			<code>
				&lt;style="background-color:0xFFF44336;"&gt;value&lt;/style&gt;
			</code>
		</td>
	</tr>
	<tr>
	<td>Blockquote</td>
		<td>
			<code>
				RichTrexSpan(text:"value", blockquote: true)
			</code>
		</td>
		<td>
			<code>
				&lt;style="decoration:blockquote;"&gt;value&lt;/style&gt;
			</code>
		</td>
	</tr>
	<tr>
	<td>Color</td>
		<td>
			<code>
				RichTrexSpan(text:"value", color: Colors.red)
			</code>
		</td>
		<td>
			<code>
				&lt;style="font-color:0xFFF44336;"&gt;value&lt;/style&gt;
			</code>
		</td>
	</tr>
	<tr>
	<td>Font Family</td>
		<td>
			<code>
				RichTrexSpan(text: "value", fontFamily: "Dancing")
			</code>
		</td>
		<td>
			<code>
				&lt;style="font-family:Dancing;"&gt;value&lt;/style&gt;
			</code>
		</td>
	</tr>
	<tr>
	<td>Font Size</td>
		<td>
			<code>
				RichTrexSpan(text:"value", fontSize: 30.0)
			</code>
		</td>
		<td>
			<code>
				&lt;style="font-size:30;"&gt;value&lt;/style&gt;
			</code>
		</td>
	</tr>
	<tr>
	<td>Font Weight</td>
		<td>
			<code>
				RichTrexSpan(text: "value", fontWeight: FontWeight.bold)
			</code>
		</td>
		<td>
			<code>
				&lt;style="font-weight:6;"&gt;value&lt;/style&gt;
			</code>
		</td>
	</tr>
	<tr>
	<td>Horizontal Space</td>
		<td>
			<code>
				RichTrexSpan(text:"value", horizontalSpace: 10.0)
			</code>
		</td>
		<td>
			<code>
				&lt;style="horizontal-space:10;"&gt;value&lt;/style&gt;
			</code>
		</td>
	</tr>
	<tr>
	<td>Hyperlink</td>
		<td>
			<code>
				RichTrexSpan(text: "value", hyperlink: "https://github.com/Nialixus")
			</code>
		</td>
		<td>
			<code>
				&lt;style="hyperlink:https://github.com/Nialixus;"&gt;value&lt;/style&gt;
			</code>
		</td>
	</tr>
	<tr>
	<td>Image</td>
		<td>
			<code>
				RichTrexSpan.image(image: RichTrexImage.network("https://avatars.githubusercontent.com/u/45191605?v=4", size: Size(70, 70)))
			</code>
		</td>
		<td>
			<code>
		&lt;widget="image-network:https://avatars.githubusercontent.com/u/45191605?v=4;image-width:70;image-height:70;"/&gt;
			</code>
		</td>
	</tr>
	<tr>
	<td>Italic</td>
		<td>
			<code>
				RichTrexSpan(text: "value", italic: true)
			</code>
		</td>
		<td>
			<code>
				&lt;style="decoration:italic;"&gt;value&lt;/style&gt;
			</code>
		</td>
	</tr>
	<tr>
	<td>Overline</td>
		<td>
			<code>
				RichTrexSpan(text: "value", overline: true)
			</code>
		</td>
		<td>
			<code>
				&lt;style="decoration:overline;"&gt;value&lt;/style&gt;
			</code>
		</td>
	</tr>
	<tr>
	<td>Padding</td>
		<td>
			<code>
				RichTrexSpan(text: "value", padding: EdgeInsets.all(20.0))
			</code>
		</td>
		<td>
			<code>
				&lt;style="padding-left:20.0;padding-top:20.0;padding-right:20.0;padding-bottom:20.0;"&gt;value&lt;/style&gt;
			</code>
		</td>
	</tr>
	<tr>
	<td>Shadow</td>
		<td>
			<code>
				RichTrexSpan(text: "value", shadow: Shadow(color: Colors.red, blurRadius: 10, offset: Offset(-1, -1)))
			</code>
		</td>
		<td>
			<code>
				&lt;style="shadow-color:0xFFF44336;shadow-blur:10.0;shadow-vertical:-1.0;shadow-horizontal:-1.0;"&gt;value&lt;/style&gt;
			</code>
		</td>
	</tr>
	<tr>
	<td>Strikethrough</td>
		<td>
			<code>
				RichTrexSpan(text: "value", strikeThrough: true)
			</code>
		</td>
		<td>
			<code>
				&lt;style="decoration:strikethrough;"&gt;value&lt;/style&gt;
			</code>
		</td>
	</tr>
	<tr>
	<td>Underline</td>
		<td>
			<code>
				RichTrexSpan(text: "value", underline: true)
			</code>
		</td>
		<td>
			<code>
				&lt;style="decoration:underline;"&gt;value&lt;/style&gt;
			</code>
		</td>
	</tr>
	<tr>
	<td>Vertical Space</td>
		<td>
			<code>
				RichTrexSpan(text:"value", verticalSpace: 10.0)
			</code>
		</td>
		<td>
			<code>
				&lt;style="vertical-space:10;"&gt;value&lt;/style&gt;
			</code>
		</td>
	</tr>
</table>
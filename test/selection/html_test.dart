import 'dart:html' as html;
import 'package:test/test.dart';
import 'package:d3/js/d3.dart';

main() {
  group('select(body)', () {
    group('on a simple page', () {
      var body = select('body');
      test('sets the inner HTML as a string', () {
        body.html('<h1>Hello, world!</h1>');
        final html.Element firstChild = body.node().firstChild;
        expect(firstChild.tagName, equals('H1'));
        expect(firstChild.text, equals('Hello, world!'));
      });
      test('sets the inner HTML as a number', () {
        body.html(42);
        expect(body.node().innerHtml, equals('42'));
        expect(body.node().firstChild.nodeType, equals(3));
      });
      test('sets the inner HTML as a function', () {
        body.data(['Subject']).html((d, i) {
          return '<b>$d</b><i>$i</i>';
        });
        final html.Element firstChild = body.node().firstChild;
        expect(firstChild.tagName, equals('B'));
        expect(firstChild.text, equals('Subject'));
        final html.Element lastChild = body.node().lastChild;
        expect(lastChild.tagName, equals('I'));
        expect(lastChild.text, equals('0'));
      });
      test('clears the inner HTML as null', () {
        body.html(null);
        expect(body.node().innerHtml, equals(''));
        expect(body.node().firstChild, isNull);
      });
      test('clears the inner HTML as null', () {
        body.html(null);
        expect(body.node().innerHtml, equals(''));
        expect(body.node().firstChild, isNull);
      });
      test('clears the inner HTML as the empty string', () {
        body.html('');
        expect(body.node().innerHtml, equals(''));
        expect(body.node().firstChild, isNull);
      });
      test('clears the inner HTML as a function returning the empty string',
          () {
        body.html(() {
          return '';
        });
        expect(body.node().innerHtml, equals(''));
        expect(body.node().firstChild, isNull);
      });
      test('clears the inner HTML as a function returning null', () {
        body.text(() {
          return null;
        });
        expect(body.node().innerHtml, equals(''));
        expect(body.node().firstChild, isNull);
      });
      test('returns the current selection', () {
        expect(body..html('foo'), same(body));
      });
      test('ignores null nodes', () {
        var node = body.node();
        body[0][0] = null;
        node.innerHtml = '<h1>foo</h1>';
        body.html('bar');
        expect(node.text, equals('foo'));
      });
    });
  });
}

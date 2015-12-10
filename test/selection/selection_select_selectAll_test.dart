import 'package:test/test.dart';
import 'package:d3/js/d3.dart';

import '../util.dart';

main() {
  group('selectAll(div)', () {
    group('on a simple page', () {
      var div =
          select('body').selectAll('div').data([0, 1]).enter().append('div');
      div.append('span').attr('class', 'first');
      div.append('span').attr('class', 'second');
      test('selects the first matching element', () {
        var span = div.select('span');
        expect(span[0][0].parentNode, same(div[0][0]));
        expect(span[0][1].parentNode, same(div[0][1]));
        expect(span.length, equals(1));
        expect(span[0].length, equals(2));
        expect(span.attr('class'), equals('first'));
      });
      test('propagates parent node to the selected elements', () {
        var span = div.select('span');
        expect(parentNode(span[0]), isNotNull);
        expect(parentNode(span[0]), same(parentNode(div.node())));
        expect(parentNode(span[0]), same(parentNode(div[0])));
      });
      test('propagates data to the selected elements', () {
        var data = new Object(), span = div.data([data]).select('span');
        expect(nodeData(span[0][0]), same(data));
      });
      test('does not propagate data if no data was specified', () {
        deleteNodeData(div[0][0]);
        deleteNodeData(div[0][1]);
        var a = new Object(), b = new Object();
        var span = div.select('span').data([a, b]);
        span = div.select('span');
        expect(nodeData(span[0][0]), same(a));
        expect(nodeData(span[0][1]), same(b));
        expect(nodeData(div[0][0]), isNull);
        expect(nodeData(div[0][1]), isNull);
      });
      test('returns null if no match is found', () {
        var div2 = div.select('div');
        expect(div2[0][0], isNull);
        expect(div2[0][1], isNull);
        expect(div2.length, equals(1));
        expect(div2[0].length, equals(2));
      });
      test('can select via function', () {
        var dd = [], ii = [], tt = [];
        var s = div.data(['a', 'b']).select((node, d, i) {
          dd.add(d);
          ii.add(i);
          tt.add(node);
          return node.firstChild;
        });
        expect(dd, equals(['a', 'b']));
        expect(ii, equals([0, 1]));
        expect(tt[0], equals(div[0][0]));
        expect(tt[1], equals(div[0][1]));
        expect(s[0][0], equals(div[0][0].firstChild));
        expect(s[0][1], equals(div[0][1].firstChild));
      });
      test('ignores null nodes', () {
        div[0][1] = null;
        var span = div.select('span');
        expect(span.length, equals(1));
        expect(span[0].length, equals(2));
        expect(span[0][0].parentNode, same(div[0][0]));
        expect(span[0][1], isNull);
      });
    });
  });
}

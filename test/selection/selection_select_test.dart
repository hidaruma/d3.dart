import 'package:test/test.dart';
import 'package:d3/js/d3.dart';

import '../util.dart';

main() {
  group('select(body)', () {
    group('on a simple page', () {
      var body = select('body');

      body.append('div').attr('class', 'first');
      body.append('div').attr('class', 'second');
      test('selects the first matching element', () {
        var div = body.select('div');
//        expect(div[0][0], same(body.node().firstChild));
        expect(div.size(), equals(1));
        expect(div[0].length, equals(1));
        expect(div.attr('class'), equals('first'));
      });
      test('propagates parent node to the selected elements', () {
        var div = body.select('div');
        expect(parentNode(div[0]), isNotNull);
        expect(parentNode(div[0]), same(parentNode(body.node())));
        expect(parentNode(div[0]), same(parentNode(body[0])));
      });
      test('propagates data to the selected elements', () {
        var data = new Object(), div = body.data([data]).select('div');
        expect(nodeData(div[0][0]), same(data));
      });
      test('does not propagate data if no data was specified', () {
        deleteNodeData(body.node());
        var data = new Object(), div = body.select('div').data([data]);
        div = body.select('div');
        expect(nodeData(div[0][0]), same(data));
        expect(nodeData(body.node()), isNull);
      });
      test('returns null if no match is found', () {
        var span = body.select('span');
        expect(span[0][0], isNull);
        expect(span.length, equals(1));
        expect(span[0].length, equals(1));
      });
      test('can select via function', () {
        body.append('foo');
        var d = {}, dd = [], ii = [], tt = [];
        var s = body.data([d]).select((node, d, i) {
          dd.add(d);
          ii.add(i);
          tt.add(node);
          return node.firstChild;
        });
        expect(dd, equals([d]));
        expect(ii, equals([0]));
        expect(tt[0], equals(body.node()));
        expect(s[0][0], equals(body.node().firstChild));
        deleteNodeData(body.node());
      });
    });
  });
}

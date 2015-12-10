import 'package:test/test.dart';
import 'package:d3/js/d3.dart';

main() {
  group('select(body)', () {
    group('on a simple page', () {
      final Selection body = select('body');
      test('calls the function once per element', () {
        var count = 0;
        body.each(() {
          ++count;
        });
        expect(count, equals(1));
      });
      test('passes the data and index to the function', () {
        var data = new Object(), dd, ii;
        body.data([data]).each((d, i) {
          dd = d;
          ii = i;
        });
        expect(dd, same(data));
        expect(ii, same(0));
      });
      test('uses the node as the context', () {
        var node = null;
        body.each((n, d, i) {
          node = n;
        });
        expect(node, same(body.node()));
      });
      test('returns the same selection', () {
        expect(body.each(() {}), same(body));
      });
      test('returns the current selection', () {
        expect(body.each(() {}), same(body));
      });
      test('ignores null nodes', () {
        var count = 0;
        body[0][0] = null;
        body.each(() {
          ++count;
        });
        expect(count, equals(0));
      });
    });
  });
}

import 'package:test/test.dart';
import 'package:d3/js/d3.dart';

main() {
  group('select(body)', () {
    group('on an initially-empty page', () {
      var body = select('body');
      test('sets a property as a string', () {
        body.style('background-color', 'red');
        expect(body.node().style.getPropertyValue('background-color'),
            equals('red'));
      });
      test('sets a property as a number', () {
        body.style('opacity', .3);
        expect(body.node().style.getPropertyValue('opacity'), equals('0.3'));
      });
      test('sets a property as a function', () {
        body.style('background-color', (n, d, i) {
          return 'orange';
        });
        expect(body.node().style.getPropertyValue('background-color'),
            equals('orange'));
      });
      test('sets properties as a map of constants', () {
        body.style({'background-color': 'white', 'opacity': .42});
        expect(body.node().style.getPropertyValue('background-color'),
            equals('white'));
        expect(body.node().style.getPropertyValue('opacity'), equals('0.42'));
      });
      test('sets properties as a map of functions', () {
        body.data(['orange']).style({
          'background-color': (d, i, j) {
            return d;
          },
          'opacity': (d, i, j) {
            return i;
          }
        });
        expect(body.node().style.getPropertyValue('background-color'),
            equals('orange'));
        expect(body.node().style.getPropertyValue('opacity'), equals('0'));
      });
//      test('gets a property value', () {
//        body.node().style.setProperty('background-color', 'yellow', '');
//        expect(body.style('background-color'), equals('yellow'));
//      });
      test('observes the specified priority', () {
        body.style('background-color', 'green', 'important');
        expect(body.node().style.getPropertyPriority('background-color'),
            equals('important'));
        body.style({'opacity': .52}, 'important');
        expect(body.node().style.getPropertyPriority('opacity'),
            equals('important'));
        body.style({
          'visibility': (n, d, i) {
            return 'visible';
          }
        }, 'important');
        expect(body.node().style.getPropertyPriority('visibility'),
            equals('important'));
      });
//      test('removes a property as null', () {
//        body.style('background-color', 'green').style('background-color', null);
//        expect(body.style('background-color'), equals(''));
//      });
//      test('removes a property as a function', () {
//        body.style('background-color', 'green').style('background-color', () { return null; });
//        expect(body.style('background-color'), equals(''));
//      });
//      test('removes properties as a map of nulls', () {
//        body.node().style.setProperty('background-color', 'purple');
//        body.style({'background-color': null});
//        expect(body.style('background-color'), equals(''));
//      });
//      test('removes properties as a map of functions that return null', () {
//        body.node().style.setProperty('background-color', 'purple');
//        body.style({'background-color': () {}});
//        expect(body.style('background-color'), equals(''));
//      });
      test('returns the current selection', () {
        expect(body..style('background-color', 'green'), same(body));
      });
    });
  });
}

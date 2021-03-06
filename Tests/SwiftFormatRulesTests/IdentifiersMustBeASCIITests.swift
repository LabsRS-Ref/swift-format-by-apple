import SwiftFormatRules

final class IdentifiersMustBeASCIITests: LintOrFormatRuleTestCase {
  func testInvalidIdentifiers() {
    let input =
    """
      let Te$t = 1
      var foðo = 2
      let Îx = newX - previousX
      var ð¤©ð = 20
      """
    performLint(IdentifiersMustBeASCII.self, input: input)
    XCTAssertDiagnosed(.nonASCIICharsNotAllowed(["ð"],"foðo"))
    // TODO: It would be nice to allow Î (among other mathematically meaningful symbols) without
    // a lot of special cases; investigate this.
    XCTAssertDiagnosed(.nonASCIICharsNotAllowed(["Î"],"Îx"))
    XCTAssertDiagnosed(.nonASCIICharsNotAllowed(["ð¤©", "ð"], "ð¤©ð"))
  }
}

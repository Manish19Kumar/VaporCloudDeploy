
import Vapor
// import FluentMySQL
// import FluentSQLite
import FluentPostgreSQL
final class Acronym: Codable {
    var id: Int?
    var short: String
    var long: String
    init(short: String, long: String) {
        self.short = short
        self.long = long
    }
}

//extension Acronym: Model {
//    // 1. Tell Fluent what database to use for this model. The template is already configured to use SQLite.
//    typealias Database = SQLiteDatabase
//    // 2. Tell Fluent what type the ID is.
//    typealias ID = Int
//    // 3. Tell Fluent the key path of the model’s ID property.
//    public static var idKey: IDKey = \Acronym.id
//}
/*extension Acronym: SQLiteModel {
    
}
 */

//extension Acronym: MySQLModel {}
extension Acronym: PostgreSQLModel {}
extension Acronym: Migration {}

extension Acronym: Content {}

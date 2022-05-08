package db
import(
	"context",
	"database/sql"
	"log"
	"testing"
	_ "github.com/lib/pq"
)
const (
	dbDriver = "postgres"
	dbSource = "postgresql://cms_app:CmsStaticApp@192.168.1.40:5432/cms?sslmode=disable"
)
var testQueries *Queries
func TestMain(m *testing.M) {	
	testDB, err = sql.Open(config.DBDriver, config.DBSource)
	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}
	testQueries = New(testDB)
	os.Exit(m.Run())
}
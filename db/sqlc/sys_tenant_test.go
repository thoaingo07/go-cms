package db
import "testing"
func TestAddSysTenant(t *testing.T){
	arg := AddSysTenantParams{
		Code: "clockwork",
		Name:  "Clockwork Property Management",
		SessionTimeout: 30,
	}
	sysTenant, err := testQueries.AddSysTenant(context.Background(), arg)
	require.NoError(t, err)
	require.NotEmpty(t, arg)

	require.Equal(t, arg.Code, sysTenant.Code)
	require.Equal(t, arg.Name, sysTenant.Name)
	require.Equal(t, arg.SessionTimeout, sysTenant.SessionTimeout)

	require.NotZero(t, sysTenant.ID)

}
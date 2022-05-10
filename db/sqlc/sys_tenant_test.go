package db

import (
	"context"
	"database/sql"
	"testing"
	"time"

	"github.com/google/uuid"
	gonanoid "github.com/matoous/go-nanoid/v2"
	"github.com/stretchr/testify/require"
)

func TestAddSysTenant(t *testing.T) {
	nanoID, err := gonanoid.New(12)
	arg := AddSysTenantParams{
		UniqueID:       uuid.NullUUID{uuid.New(), true},
		HandleID:       nanoID,
		Code:           sql.NullString{"clockwork", true},
		Name:           sql.NullString{"Clockwork Property Management", true},
		SessionTimeout: sql.NullInt32{32, true},
		CreatedDate:    sql.NullTime{time.Now(), true},
		UpdatedDate:    sql.NullTime{time.Now(), true},
	}
	sysTenant, err := testQueries.AddSysTenant(context.Background(), arg)
	require.NoError(t, err)
	require.NotEmpty(t, arg)

	require.Equal(t, arg.Code, sysTenant.Code)
	require.Equal(t, arg.Name, sysTenant.Name)
	require.Equal(t, arg.SessionTimeout, sysTenant.SessionTimeout)

	require.NotZero(t, sysTenant.ID)

}

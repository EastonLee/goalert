-- +migrate Up

CREATE TABLE auth_link_codes (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    auth_user_session_id UUID NOT NULL REFERENCES auth_user_sessions (id) ON DELETE CASCADE,
    claim_code TEXT NOT NULL UNIQUE,
    verify_code TEXT NOT NULL,
    expires_at TIMESTAMPTZ NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    claimed_at TIMESTAMPTZ,
    verified_at TIMESTAMPTZ,
    authed_at TIMESTAMPTZ
);

CREATE UNIQUE INDEX idx_auth_link_user on auth_link_codes (user_id) where authed_at isnull;

-- +migrate Down

DROP TABLE auth_link_codes;

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.9 (Debian 16.9-1.pgdg120+1)
-- Dumped by pg_dump version 16.9 (Debian 16.9-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO keycloak;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO keycloak;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO keycloak;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO keycloak;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO keycloak;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO keycloak;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO keycloak;

--
-- Name: client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO keycloak;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO keycloak;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO keycloak;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO keycloak;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO keycloak;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO keycloak;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO keycloak;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO keycloak;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO keycloak;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO keycloak;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO keycloak;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO keycloak;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO keycloak;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO keycloak;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO keycloak;

--
-- Name: component; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO keycloak;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO keycloak;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO keycloak;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO keycloak;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO keycloak;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO keycloak;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO keycloak;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO keycloak;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.fed_user_attribute OWNER TO keycloak;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO keycloak;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO keycloak;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO keycloak;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO keycloak;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO keycloak;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO keycloak;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO keycloak;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO keycloak;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO keycloak;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO keycloak;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO keycloak;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO keycloak;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO keycloak;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO keycloak;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO keycloak;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO keycloak;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO keycloak;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL,
    version integer DEFAULT 0
);


ALTER TABLE public.offline_client_session OWNER TO keycloak;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL,
    broker_session_id character varying(1024),
    version integer DEFAULT 0
);


ALTER TABLE public.offline_user_session OWNER TO keycloak;

--
-- Name: org; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.org (
    id character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    realm_id character varying(255) NOT NULL,
    group_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(4000)
);


ALTER TABLE public.org OWNER TO keycloak;

--
-- Name: org_domain; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.org_domain (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    verified boolean NOT NULL,
    org_id character varying(255) NOT NULL
);


ALTER TABLE public.org_domain OWNER TO keycloak;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO keycloak;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO keycloak;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO keycloak;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO keycloak;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO keycloak;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO keycloak;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO keycloak;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO keycloak;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO keycloak;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO keycloak;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO keycloak;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO keycloak;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO keycloak;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO keycloak;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO keycloak;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO keycloak;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO keycloak;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO keycloak;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO keycloak;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO keycloak;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO keycloak;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO keycloak;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO keycloak;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO keycloak;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO keycloak;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO keycloak;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO keycloak;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.user_attribute OWNER TO keycloak;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO keycloak;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO keycloak;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO keycloak;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO keycloak;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO keycloak;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO keycloak;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO keycloak;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO keycloak;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO keycloak;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO keycloak;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO keycloak;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO keycloak;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO keycloak;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO keycloak;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
549217c3-c658-45d5-944e-2ddff91d66b0	\N	auth-cookie	50f476a7-f350-43ba-8b98-a206554bea56	dec4313b-a830-49fc-8017-e13fb8b9a259	2	10	f	\N	\N
67f8ec0f-52c3-4d55-aeb1-cfa075beb720	\N	auth-spnego	50f476a7-f350-43ba-8b98-a206554bea56	dec4313b-a830-49fc-8017-e13fb8b9a259	3	20	f	\N	\N
6051b3f2-5764-4c87-a54c-2d6b5afcea69	\N	identity-provider-redirector	50f476a7-f350-43ba-8b98-a206554bea56	dec4313b-a830-49fc-8017-e13fb8b9a259	2	25	f	\N	\N
35cc592a-4a52-4b5b-9432-62f84e24d512	\N	\N	50f476a7-f350-43ba-8b98-a206554bea56	dec4313b-a830-49fc-8017-e13fb8b9a259	2	30	t	fb042f47-9a3c-49d3-9bc5-bd2ecf629ad2	\N
b9b2643b-6646-415f-8b44-d375938f9065	\N	auth-username-password-form	50f476a7-f350-43ba-8b98-a206554bea56	fb042f47-9a3c-49d3-9bc5-bd2ecf629ad2	0	10	f	\N	\N
87678c71-0099-4a6f-aac6-1279489f62e6	\N	\N	50f476a7-f350-43ba-8b98-a206554bea56	fb042f47-9a3c-49d3-9bc5-bd2ecf629ad2	1	20	t	b3d8a1dd-b261-42c2-9010-61f3b1158a93	\N
fe5e6d14-254d-4780-8c2a-6b57adda483d	\N	conditional-user-configured	50f476a7-f350-43ba-8b98-a206554bea56	b3d8a1dd-b261-42c2-9010-61f3b1158a93	0	10	f	\N	\N
d4ef4147-2483-4bf4-adf1-ef454be32467	\N	auth-otp-form	50f476a7-f350-43ba-8b98-a206554bea56	b3d8a1dd-b261-42c2-9010-61f3b1158a93	0	20	f	\N	\N
89a894f8-913b-4460-b93b-782b33c345f2	\N	direct-grant-validate-username	50f476a7-f350-43ba-8b98-a206554bea56	69ecc80a-f114-4efb-b55f-f3a22363639f	0	10	f	\N	\N
ab7cd6f8-d467-4659-9f19-a0ddf1ba15cf	\N	direct-grant-validate-password	50f476a7-f350-43ba-8b98-a206554bea56	69ecc80a-f114-4efb-b55f-f3a22363639f	0	20	f	\N	\N
96d9a1a6-b72f-4e20-ab67-a0a73a6066d4	\N	\N	50f476a7-f350-43ba-8b98-a206554bea56	69ecc80a-f114-4efb-b55f-f3a22363639f	1	30	t	e60a3c79-baec-4d22-bf63-06b6ba80ee64	\N
bac16ae6-27fd-421a-9933-1f38c3ed6448	\N	conditional-user-configured	50f476a7-f350-43ba-8b98-a206554bea56	e60a3c79-baec-4d22-bf63-06b6ba80ee64	0	10	f	\N	\N
4e72cad9-ad97-4a86-be1f-e86295261d03	\N	direct-grant-validate-otp	50f476a7-f350-43ba-8b98-a206554bea56	e60a3c79-baec-4d22-bf63-06b6ba80ee64	0	20	f	\N	\N
d415c254-e7bc-4f94-a7df-a7cb63205d09	\N	registration-page-form	50f476a7-f350-43ba-8b98-a206554bea56	4b14939b-0dd3-4007-b397-74e95019f410	0	10	t	bb558aa2-9cdd-47ca-9841-588ab3dc97bf	\N
2c32ee70-f3cb-4fe0-a474-3d068064afd6	\N	registration-user-creation	50f476a7-f350-43ba-8b98-a206554bea56	bb558aa2-9cdd-47ca-9841-588ab3dc97bf	0	20	f	\N	\N
8e04032d-9eed-4269-b572-797b2b488b7a	\N	registration-password-action	50f476a7-f350-43ba-8b98-a206554bea56	bb558aa2-9cdd-47ca-9841-588ab3dc97bf	0	50	f	\N	\N
3cce25e3-cf21-4aa2-ba6f-d0468324606c	\N	registration-recaptcha-action	50f476a7-f350-43ba-8b98-a206554bea56	bb558aa2-9cdd-47ca-9841-588ab3dc97bf	3	60	f	\N	\N
2a9a0e1f-6247-40fd-b399-47e5f2139ae5	\N	registration-terms-and-conditions	50f476a7-f350-43ba-8b98-a206554bea56	bb558aa2-9cdd-47ca-9841-588ab3dc97bf	3	70	f	\N	\N
670ddb3e-d61c-4fd9-8e7e-3c5a2d37c423	\N	reset-credentials-choose-user	50f476a7-f350-43ba-8b98-a206554bea56	ba229d13-958d-4d58-a1c3-37a8a251d965	0	10	f	\N	\N
6f647464-76c1-4407-9c46-aa1ba5695ac8	\N	reset-credential-email	50f476a7-f350-43ba-8b98-a206554bea56	ba229d13-958d-4d58-a1c3-37a8a251d965	0	20	f	\N	\N
5e11223f-73ec-4ca6-b381-24c5c5bfeacb	\N	reset-password	50f476a7-f350-43ba-8b98-a206554bea56	ba229d13-958d-4d58-a1c3-37a8a251d965	0	30	f	\N	\N
a8fa954e-c2c2-4d70-a3ef-97b362b5d2ef	\N	\N	50f476a7-f350-43ba-8b98-a206554bea56	ba229d13-958d-4d58-a1c3-37a8a251d965	1	40	t	0af7a39a-f214-4b22-b188-89fe3372137c	\N
5e36e7a0-20e6-4fa2-b405-a83863b2985f	\N	conditional-user-configured	50f476a7-f350-43ba-8b98-a206554bea56	0af7a39a-f214-4b22-b188-89fe3372137c	0	10	f	\N	\N
a250a7de-2790-4d64-b3d8-1e44e9e75221	\N	reset-otp	50f476a7-f350-43ba-8b98-a206554bea56	0af7a39a-f214-4b22-b188-89fe3372137c	0	20	f	\N	\N
ba97c3ba-c41e-4a5d-8b1c-cab135726733	\N	client-secret	50f476a7-f350-43ba-8b98-a206554bea56	2799b417-48c7-45cc-b11a-f0d46a0280f1	2	10	f	\N	\N
778d9734-36c0-42bf-b2bd-ddb60137ca32	\N	client-jwt	50f476a7-f350-43ba-8b98-a206554bea56	2799b417-48c7-45cc-b11a-f0d46a0280f1	2	20	f	\N	\N
07530fd6-71d7-4f16-97ee-a5d3da4a40c1	\N	client-secret-jwt	50f476a7-f350-43ba-8b98-a206554bea56	2799b417-48c7-45cc-b11a-f0d46a0280f1	2	30	f	\N	\N
dee11955-dd4a-4a78-99cd-85eec8021c8e	\N	client-x509	50f476a7-f350-43ba-8b98-a206554bea56	2799b417-48c7-45cc-b11a-f0d46a0280f1	2	40	f	\N	\N
9fdf1299-07f6-4f0d-b8cc-498a63eb6a19	\N	idp-review-profile	50f476a7-f350-43ba-8b98-a206554bea56	705bee5d-1cca-4055-8750-e4947b5e75b3	0	10	f	\N	e1891bc2-ce7f-45c2-9305-a0b034e3baa1
3da22625-aa7b-45d8-833c-0f27f9b35c79	\N	\N	50f476a7-f350-43ba-8b98-a206554bea56	705bee5d-1cca-4055-8750-e4947b5e75b3	0	20	t	bdcf0ae3-2867-43fd-8800-a4dbf06b8bb9	\N
e641a664-0181-466a-a037-84625ac35362	\N	idp-create-user-if-unique	50f476a7-f350-43ba-8b98-a206554bea56	bdcf0ae3-2867-43fd-8800-a4dbf06b8bb9	2	10	f	\N	c39971d4-4a94-4c8f-aaee-ae5b53a6f3a8
33b60884-0560-496a-a1df-5454e1921ce3	\N	\N	50f476a7-f350-43ba-8b98-a206554bea56	bdcf0ae3-2867-43fd-8800-a4dbf06b8bb9	2	20	t	8e55ed77-767e-4e35-b42e-4dc7f8407702	\N
4170a7ff-0fd6-4d04-9503-b253739d30e0	\N	idp-confirm-link	50f476a7-f350-43ba-8b98-a206554bea56	8e55ed77-767e-4e35-b42e-4dc7f8407702	0	10	f	\N	\N
d0ec54bc-d153-4461-a49f-486130e99d7a	\N	\N	50f476a7-f350-43ba-8b98-a206554bea56	8e55ed77-767e-4e35-b42e-4dc7f8407702	0	20	t	bd037c56-2fb1-4485-8471-bb2b4b8727f3	\N
892ffcb7-429a-4598-bc31-a2d1a9e8e0cd	\N	idp-email-verification	50f476a7-f350-43ba-8b98-a206554bea56	bd037c56-2fb1-4485-8471-bb2b4b8727f3	2	10	f	\N	\N
254665f6-00ad-4679-8a43-f81d375210ad	\N	\N	50f476a7-f350-43ba-8b98-a206554bea56	bd037c56-2fb1-4485-8471-bb2b4b8727f3	2	20	t	7573720c-56df-4e26-be9c-5c90aa86089b	\N
757d12e1-0c22-45b9-8281-91595e01ca75	\N	idp-username-password-form	50f476a7-f350-43ba-8b98-a206554bea56	7573720c-56df-4e26-be9c-5c90aa86089b	0	10	f	\N	\N
e2db51bd-03d1-4dd1-b852-547a1922d63b	\N	\N	50f476a7-f350-43ba-8b98-a206554bea56	7573720c-56df-4e26-be9c-5c90aa86089b	1	20	t	5713c020-b8e5-440d-8ecc-9c9a6e80769c	\N
4b606a91-8994-4b98-88bb-55ca7055fcef	\N	conditional-user-configured	50f476a7-f350-43ba-8b98-a206554bea56	5713c020-b8e5-440d-8ecc-9c9a6e80769c	0	10	f	\N	\N
1255bd49-5d69-4208-a743-46f2881eb90a	\N	auth-otp-form	50f476a7-f350-43ba-8b98-a206554bea56	5713c020-b8e5-440d-8ecc-9c9a6e80769c	0	20	f	\N	\N
532e62f8-df1a-43b8-b6f0-103c54f74779	\N	http-basic-authenticator	50f476a7-f350-43ba-8b98-a206554bea56	dd04f901-0b60-4908-b698-ef042fb2ff56	0	10	f	\N	\N
963b6f56-0631-45dd-af29-0f085b23b68d	\N	docker-http-basic-authenticator	50f476a7-f350-43ba-8b98-a206554bea56	7f0fc537-bc20-46a2-b4e7-793080a6949c	0	10	f	\N	\N
f43a20dc-bc4c-4916-b2ca-3d7b15a9a324	\N	auth-cookie	2fc07f5a-9f12-47ad-8999-54ec21d06664	2f28fe5e-1b4a-44ce-a9d3-91dca9e08b91	2	10	f	\N	\N
213a72df-c106-4f61-8573-414f03fbbe68	\N	auth-spnego	2fc07f5a-9f12-47ad-8999-54ec21d06664	2f28fe5e-1b4a-44ce-a9d3-91dca9e08b91	3	20	f	\N	\N
197c162c-890f-4302-bbc1-05bb01d15e4a	\N	identity-provider-redirector	2fc07f5a-9f12-47ad-8999-54ec21d06664	2f28fe5e-1b4a-44ce-a9d3-91dca9e08b91	2	25	f	\N	\N
697f2ece-d8b6-425a-bb7d-d7030f2fac3f	\N	\N	2fc07f5a-9f12-47ad-8999-54ec21d06664	2f28fe5e-1b4a-44ce-a9d3-91dca9e08b91	2	30	t	309c9bc3-dada-4b7e-b74c-05d3ca47b913	\N
525df4fa-c903-460c-b6b7-8b636a29ca6b	\N	auth-username-password-form	2fc07f5a-9f12-47ad-8999-54ec21d06664	309c9bc3-dada-4b7e-b74c-05d3ca47b913	0	10	f	\N	\N
3c192016-663f-4691-9ee2-e4178dd9b1cc	\N	\N	2fc07f5a-9f12-47ad-8999-54ec21d06664	309c9bc3-dada-4b7e-b74c-05d3ca47b913	1	20	t	190dd6a2-9a55-4a80-a9cb-5f2a042ef80a	\N
187b6487-757b-46b2-a739-f8f9eaaec144	\N	conditional-user-configured	2fc07f5a-9f12-47ad-8999-54ec21d06664	190dd6a2-9a55-4a80-a9cb-5f2a042ef80a	0	10	f	\N	\N
68124cec-31c7-488f-b64b-6f153ea66ac6	\N	auth-otp-form	2fc07f5a-9f12-47ad-8999-54ec21d06664	190dd6a2-9a55-4a80-a9cb-5f2a042ef80a	0	20	f	\N	\N
9f47085d-e95a-4977-a4a2-c1fc5f7266d5	\N	direct-grant-validate-username	2fc07f5a-9f12-47ad-8999-54ec21d06664	6ab06add-6064-442f-a9aa-ed19d461b72b	0	10	f	\N	\N
b072f71d-f156-4094-8cc2-7270c4a505bb	\N	direct-grant-validate-password	2fc07f5a-9f12-47ad-8999-54ec21d06664	6ab06add-6064-442f-a9aa-ed19d461b72b	0	20	f	\N	\N
7a32f989-ea45-4ac0-8e85-330f0b60df95	\N	\N	2fc07f5a-9f12-47ad-8999-54ec21d06664	6ab06add-6064-442f-a9aa-ed19d461b72b	1	30	t	09ac3ddd-a736-4bdb-8680-9f4a3573a922	\N
6586a388-4dcc-4ff2-8e2c-4cd87d7642e3	\N	conditional-user-configured	2fc07f5a-9f12-47ad-8999-54ec21d06664	09ac3ddd-a736-4bdb-8680-9f4a3573a922	0	10	f	\N	\N
68b59a9b-539c-41af-8b58-c9d817f4736c	\N	direct-grant-validate-otp	2fc07f5a-9f12-47ad-8999-54ec21d06664	09ac3ddd-a736-4bdb-8680-9f4a3573a922	0	20	f	\N	\N
78a38d86-5693-4c39-979e-a05eb535614e	\N	registration-page-form	2fc07f5a-9f12-47ad-8999-54ec21d06664	1f9d6f1a-f889-4c2c-a5c0-a3d4df0f253d	0	10	t	68ab4852-4f17-4898-9a1a-a8c99da18794	\N
176bcb12-3e48-4fd0-a507-7c76b57d7fec	\N	registration-user-creation	2fc07f5a-9f12-47ad-8999-54ec21d06664	68ab4852-4f17-4898-9a1a-a8c99da18794	0	20	f	\N	\N
f8f801e8-82d5-4d6f-af1c-c3568a3a8ae0	\N	registration-password-action	2fc07f5a-9f12-47ad-8999-54ec21d06664	68ab4852-4f17-4898-9a1a-a8c99da18794	0	50	f	\N	\N
55adb616-de1e-48e7-b07a-a2a08131a9b9	\N	registration-recaptcha-action	2fc07f5a-9f12-47ad-8999-54ec21d06664	68ab4852-4f17-4898-9a1a-a8c99da18794	3	60	f	\N	\N
969e28ea-41f9-49a2-874d-ff868b974fed	\N	registration-terms-and-conditions	2fc07f5a-9f12-47ad-8999-54ec21d06664	68ab4852-4f17-4898-9a1a-a8c99da18794	3	70	f	\N	\N
e7e6f431-d6ae-40c2-aa59-4843d4f3062a	\N	reset-credentials-choose-user	2fc07f5a-9f12-47ad-8999-54ec21d06664	37a13e8c-997e-462e-86d5-67c3bba3971f	0	10	f	\N	\N
db1aec99-0ad0-44ab-8308-05f169b489b8	\N	reset-credential-email	2fc07f5a-9f12-47ad-8999-54ec21d06664	37a13e8c-997e-462e-86d5-67c3bba3971f	0	20	f	\N	\N
6cf717ad-c4de-47ae-806d-ad1eb0e3fbed	\N	reset-password	2fc07f5a-9f12-47ad-8999-54ec21d06664	37a13e8c-997e-462e-86d5-67c3bba3971f	0	30	f	\N	\N
4b872823-ce28-49d8-afa4-74b6707d800d	\N	\N	2fc07f5a-9f12-47ad-8999-54ec21d06664	37a13e8c-997e-462e-86d5-67c3bba3971f	1	40	t	8008ed8e-c53b-46b5-b807-e95ed1492725	\N
246290ae-7c1b-46cf-afbb-cbc6b65098dd	\N	conditional-user-configured	2fc07f5a-9f12-47ad-8999-54ec21d06664	8008ed8e-c53b-46b5-b807-e95ed1492725	0	10	f	\N	\N
d3b56bd7-d536-4c60-873b-462a3395ce06	\N	reset-otp	2fc07f5a-9f12-47ad-8999-54ec21d06664	8008ed8e-c53b-46b5-b807-e95ed1492725	0	20	f	\N	\N
81903d10-565c-4b9a-adab-8cc57413cb0d	\N	client-secret	2fc07f5a-9f12-47ad-8999-54ec21d06664	5545fd85-01bb-42a2-b10d-40a435c58fe3	2	10	f	\N	\N
3dcccb38-d2e2-4970-ba91-16ed45be7991	\N	client-jwt	2fc07f5a-9f12-47ad-8999-54ec21d06664	5545fd85-01bb-42a2-b10d-40a435c58fe3	2	20	f	\N	\N
a9231bca-aab2-408f-8dad-face49312138	\N	client-secret-jwt	2fc07f5a-9f12-47ad-8999-54ec21d06664	5545fd85-01bb-42a2-b10d-40a435c58fe3	2	30	f	\N	\N
85629955-4b78-4a5b-b679-ac800affd584	\N	client-x509	2fc07f5a-9f12-47ad-8999-54ec21d06664	5545fd85-01bb-42a2-b10d-40a435c58fe3	2	40	f	\N	\N
eb321a1c-8e86-489b-bb09-efbb57582c02	\N	idp-review-profile	2fc07f5a-9f12-47ad-8999-54ec21d06664	4ebef7b8-64de-4abe-895d-d54201bffb74	0	10	f	\N	0a5fb7d6-fd16-4c74-9517-c1f2a449f71e
b13ab83c-a290-441d-a909-af5a4e706521	\N	\N	2fc07f5a-9f12-47ad-8999-54ec21d06664	4ebef7b8-64de-4abe-895d-d54201bffb74	0	20	t	d26a98e8-abe6-4148-975a-0924342ed500	\N
e36f94ce-fd33-44bb-8a2e-bfba44d8dc62	\N	idp-create-user-if-unique	2fc07f5a-9f12-47ad-8999-54ec21d06664	d26a98e8-abe6-4148-975a-0924342ed500	2	10	f	\N	8ca8ae00-4ae2-456c-b759-f3c2b0b0a0fc
334cb107-3d75-47a8-9feb-e5f71454c373	\N	\N	2fc07f5a-9f12-47ad-8999-54ec21d06664	d26a98e8-abe6-4148-975a-0924342ed500	2	20	t	35eebe4c-846a-4fcc-bf88-31411ce197a8	\N
72d17742-a5c7-45d8-a221-bba0bcbb0945	\N	idp-confirm-link	2fc07f5a-9f12-47ad-8999-54ec21d06664	35eebe4c-846a-4fcc-bf88-31411ce197a8	0	10	f	\N	\N
fd742642-4f30-4ba8-91cc-c1afd1d249ac	\N	\N	2fc07f5a-9f12-47ad-8999-54ec21d06664	35eebe4c-846a-4fcc-bf88-31411ce197a8	0	20	t	9a1250c2-40a8-4ec6-8f34-8e5d8d4eaba5	\N
47201eab-c801-4f5b-b27c-f93ede8df423	\N	idp-email-verification	2fc07f5a-9f12-47ad-8999-54ec21d06664	9a1250c2-40a8-4ec6-8f34-8e5d8d4eaba5	2	10	f	\N	\N
3e57c39f-522d-4ab4-99e0-cc1b32abcb7e	\N	\N	2fc07f5a-9f12-47ad-8999-54ec21d06664	9a1250c2-40a8-4ec6-8f34-8e5d8d4eaba5	2	20	t	67cde747-2432-4044-9a9c-3a759aac69eb	\N
cb522d80-9484-4e52-a641-7596ef412c87	\N	idp-username-password-form	2fc07f5a-9f12-47ad-8999-54ec21d06664	67cde747-2432-4044-9a9c-3a759aac69eb	0	10	f	\N	\N
6e8af539-38e8-4cab-8d90-25f2ee59405f	\N	\N	2fc07f5a-9f12-47ad-8999-54ec21d06664	67cde747-2432-4044-9a9c-3a759aac69eb	1	20	t	36ef30d7-59ad-49da-a4aa-dfd9d3347b64	\N
05b92147-48d3-46c1-8278-8d75d297db26	\N	conditional-user-configured	2fc07f5a-9f12-47ad-8999-54ec21d06664	36ef30d7-59ad-49da-a4aa-dfd9d3347b64	0	10	f	\N	\N
a64490c1-f871-46c0-be9f-af47d360e192	\N	auth-otp-form	2fc07f5a-9f12-47ad-8999-54ec21d06664	36ef30d7-59ad-49da-a4aa-dfd9d3347b64	0	20	f	\N	\N
8cd25cda-c583-40e3-8a8e-67b73297a2b6	\N	http-basic-authenticator	2fc07f5a-9f12-47ad-8999-54ec21d06664	288d48e7-7e56-4338-8360-ecea35e357ff	0	10	f	\N	\N
1d8a491c-45eb-43c5-a388-1eff7c15ec86	\N	docker-http-basic-authenticator	2fc07f5a-9f12-47ad-8999-54ec21d06664	a09d42c9-7292-4bc2-bd1c-fab27a6eabe3	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
dec4313b-a830-49fc-8017-e13fb8b9a259	browser	browser based authentication	50f476a7-f350-43ba-8b98-a206554bea56	basic-flow	t	t
fb042f47-9a3c-49d3-9bc5-bd2ecf629ad2	forms	Username, password, otp and other auth forms.	50f476a7-f350-43ba-8b98-a206554bea56	basic-flow	f	t
b3d8a1dd-b261-42c2-9010-61f3b1158a93	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	50f476a7-f350-43ba-8b98-a206554bea56	basic-flow	f	t
69ecc80a-f114-4efb-b55f-f3a22363639f	direct grant	OpenID Connect Resource Owner Grant	50f476a7-f350-43ba-8b98-a206554bea56	basic-flow	t	t
e60a3c79-baec-4d22-bf63-06b6ba80ee64	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	50f476a7-f350-43ba-8b98-a206554bea56	basic-flow	f	t
4b14939b-0dd3-4007-b397-74e95019f410	registration	registration flow	50f476a7-f350-43ba-8b98-a206554bea56	basic-flow	t	t
bb558aa2-9cdd-47ca-9841-588ab3dc97bf	registration form	registration form	50f476a7-f350-43ba-8b98-a206554bea56	form-flow	f	t
ba229d13-958d-4d58-a1c3-37a8a251d965	reset credentials	Reset credentials for a user if they forgot their password or something	50f476a7-f350-43ba-8b98-a206554bea56	basic-flow	t	t
0af7a39a-f214-4b22-b188-89fe3372137c	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	50f476a7-f350-43ba-8b98-a206554bea56	basic-flow	f	t
2799b417-48c7-45cc-b11a-f0d46a0280f1	clients	Base authentication for clients	50f476a7-f350-43ba-8b98-a206554bea56	client-flow	t	t
705bee5d-1cca-4055-8750-e4947b5e75b3	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	50f476a7-f350-43ba-8b98-a206554bea56	basic-flow	t	t
bdcf0ae3-2867-43fd-8800-a4dbf06b8bb9	User creation or linking	Flow for the existing/non-existing user alternatives	50f476a7-f350-43ba-8b98-a206554bea56	basic-flow	f	t
8e55ed77-767e-4e35-b42e-4dc7f8407702	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	50f476a7-f350-43ba-8b98-a206554bea56	basic-flow	f	t
bd037c56-2fb1-4485-8471-bb2b4b8727f3	Account verification options	Method with which to verity the existing account	50f476a7-f350-43ba-8b98-a206554bea56	basic-flow	f	t
7573720c-56df-4e26-be9c-5c90aa86089b	Verify Existing Account by Re-authentication	Reauthentication of existing account	50f476a7-f350-43ba-8b98-a206554bea56	basic-flow	f	t
5713c020-b8e5-440d-8ecc-9c9a6e80769c	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	50f476a7-f350-43ba-8b98-a206554bea56	basic-flow	f	t
dd04f901-0b60-4908-b698-ef042fb2ff56	saml ecp	SAML ECP Profile Authentication Flow	50f476a7-f350-43ba-8b98-a206554bea56	basic-flow	t	t
7f0fc537-bc20-46a2-b4e7-793080a6949c	docker auth	Used by Docker clients to authenticate against the IDP	50f476a7-f350-43ba-8b98-a206554bea56	basic-flow	t	t
2f28fe5e-1b4a-44ce-a9d3-91dca9e08b91	browser	browser based authentication	2fc07f5a-9f12-47ad-8999-54ec21d06664	basic-flow	t	t
309c9bc3-dada-4b7e-b74c-05d3ca47b913	forms	Username, password, otp and other auth forms.	2fc07f5a-9f12-47ad-8999-54ec21d06664	basic-flow	f	t
190dd6a2-9a55-4a80-a9cb-5f2a042ef80a	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	2fc07f5a-9f12-47ad-8999-54ec21d06664	basic-flow	f	t
6ab06add-6064-442f-a9aa-ed19d461b72b	direct grant	OpenID Connect Resource Owner Grant	2fc07f5a-9f12-47ad-8999-54ec21d06664	basic-flow	t	t
09ac3ddd-a736-4bdb-8680-9f4a3573a922	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	2fc07f5a-9f12-47ad-8999-54ec21d06664	basic-flow	f	t
1f9d6f1a-f889-4c2c-a5c0-a3d4df0f253d	registration	registration flow	2fc07f5a-9f12-47ad-8999-54ec21d06664	basic-flow	t	t
68ab4852-4f17-4898-9a1a-a8c99da18794	registration form	registration form	2fc07f5a-9f12-47ad-8999-54ec21d06664	form-flow	f	t
37a13e8c-997e-462e-86d5-67c3bba3971f	reset credentials	Reset credentials for a user if they forgot their password or something	2fc07f5a-9f12-47ad-8999-54ec21d06664	basic-flow	t	t
8008ed8e-c53b-46b5-b807-e95ed1492725	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	2fc07f5a-9f12-47ad-8999-54ec21d06664	basic-flow	f	t
5545fd85-01bb-42a2-b10d-40a435c58fe3	clients	Base authentication for clients	2fc07f5a-9f12-47ad-8999-54ec21d06664	client-flow	t	t
4ebef7b8-64de-4abe-895d-d54201bffb74	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	2fc07f5a-9f12-47ad-8999-54ec21d06664	basic-flow	t	t
d26a98e8-abe6-4148-975a-0924342ed500	User creation or linking	Flow for the existing/non-existing user alternatives	2fc07f5a-9f12-47ad-8999-54ec21d06664	basic-flow	f	t
35eebe4c-846a-4fcc-bf88-31411ce197a8	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	2fc07f5a-9f12-47ad-8999-54ec21d06664	basic-flow	f	t
9a1250c2-40a8-4ec6-8f34-8e5d8d4eaba5	Account verification options	Method with which to verity the existing account	2fc07f5a-9f12-47ad-8999-54ec21d06664	basic-flow	f	t
67cde747-2432-4044-9a9c-3a759aac69eb	Verify Existing Account by Re-authentication	Reauthentication of existing account	2fc07f5a-9f12-47ad-8999-54ec21d06664	basic-flow	f	t
36ef30d7-59ad-49da-a4aa-dfd9d3347b64	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	2fc07f5a-9f12-47ad-8999-54ec21d06664	basic-flow	f	t
288d48e7-7e56-4338-8360-ecea35e357ff	saml ecp	SAML ECP Profile Authentication Flow	2fc07f5a-9f12-47ad-8999-54ec21d06664	basic-flow	t	t
a09d42c9-7292-4bc2-bd1c-fab27a6eabe3	docker auth	Used by Docker clients to authenticate against the IDP	2fc07f5a-9f12-47ad-8999-54ec21d06664	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
e1891bc2-ce7f-45c2-9305-a0b034e3baa1	review profile config	50f476a7-f350-43ba-8b98-a206554bea56
c39971d4-4a94-4c8f-aaee-ae5b53a6f3a8	create unique user config	50f476a7-f350-43ba-8b98-a206554bea56
0a5fb7d6-fd16-4c74-9517-c1f2a449f71e	review profile config	2fc07f5a-9f12-47ad-8999-54ec21d06664
8ca8ae00-4ae2-456c-b759-f3c2b0b0a0fc	create unique user config	2fc07f5a-9f12-47ad-8999-54ec21d06664
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
c39971d4-4a94-4c8f-aaee-ae5b53a6f3a8	false	require.password.update.after.registration
e1891bc2-ce7f-45c2-9305-a0b034e3baa1	missing	update.profile.on.first.login
0a5fb7d6-fd16-4c74-9517-c1f2a449f71e	missing	update.profile.on.first.login
8ca8ae00-4ae2-456c-b759-f3c2b0b0a0fc	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
0d818e3a-2fb1-49da-938d-757867de28a5	t	f	master-realm	0	f	\N	\N	t	\N	f	50f476a7-f350-43ba-8b98-a206554bea56	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
bfcbc2d9-28f2-41b3-ab8f-e3ec970dd844	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	50f476a7-f350-43ba-8b98-a206554bea56	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
dda90977-935d-46a5-9869-cf36a2ef0e96	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	50f476a7-f350-43ba-8b98-a206554bea56	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
807aea33-e235-4992-9b80-98f9cf3cef24	t	f	broker	0	f	\N	\N	t	\N	f	50f476a7-f350-43ba-8b98-a206554bea56	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
88de62f1-8110-4f86-95b6-fb4df82ef163	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	50f476a7-f350-43ba-8b98-a206554bea56	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
4376b76c-b690-4c69-87ce-fa225ed58030	t	f	admin-cli	0	t	\N	\N	f	\N	f	50f476a7-f350-43ba-8b98-a206554bea56	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
6e404e1f-3d41-475f-9a88-8c14f663b4a2	t	f	extranet-pp-realm	0	f	\N	\N	t	\N	f	50f476a7-f350-43ba-8b98-a206554bea56	\N	0	f	f	extranet-pp Realm	f	client-secret	\N	\N	\N	t	f	f	f
47f0efe6-666f-428e-985a-c4b2770df830	t	f	realm-management	0	f	\N	\N	t	\N	f	2fc07f5a-9f12-47ad-8999-54ec21d06664	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
120af667-e73e-4e08-a4e0-4d0207158d7c	t	f	account	0	t	\N	/realms/extranet-pp/account/	f	\N	f	2fc07f5a-9f12-47ad-8999-54ec21d06664	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
da27507b-edfa-44f4-a2f0-a94225bea092	t	f	account-console	0	t	\N	/realms/extranet-pp/account/	f	\N	f	2fc07f5a-9f12-47ad-8999-54ec21d06664	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
4884a5cc-31e3-4050-a98a-bc96805cfc3a	t	f	broker	0	f	\N	\N	t	\N	f	2fc07f5a-9f12-47ad-8999-54ec21d06664	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
faf611cc-6822-4e45-a870-a0b9360b785c	t	f	security-admin-console	0	t	\N	/admin/extranet-pp/console/	f	\N	f	2fc07f5a-9f12-47ad-8999-54ec21d06664	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
cf236ce0-a2d3-4125-aa9a-a9746eef3272	t	f	admin-cli	0	t	\N	\N	f	\N	f	2fc07f5a-9f12-47ad-8999-54ec21d06664	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
11ada4c6-3523-4a02-a7cf-2c3f06c7e176	t	t	api-extranet-pp	0	t	\N	\N	f	\N	f	2fc07f5a-9f12-47ad-8999-54ec21d06664	openid-connect	-1	f	f	API Extranet (local)	f	client-secret	\N	\N	\N	t	f	t	f
c123e002-011b-4645-ab5a-10d4b9929eff	t	t	front-extranet	0	t	\N	\N	f	\N	f	2fc07f5a-9f12-47ad-8999-54ec21d06664	openid-connect	-1	f	f	Front Extranet (local)	f	client-secret	\N	\N	\N	t	f	f	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
bfcbc2d9-28f2-41b3-ab8f-e3ec970dd844	post.logout.redirect.uris	+
dda90977-935d-46a5-9869-cf36a2ef0e96	post.logout.redirect.uris	+
dda90977-935d-46a5-9869-cf36a2ef0e96	pkce.code.challenge.method	S256
88de62f1-8110-4f86-95b6-fb4df82ef163	post.logout.redirect.uris	+
88de62f1-8110-4f86-95b6-fb4df82ef163	pkce.code.challenge.method	S256
120af667-e73e-4e08-a4e0-4d0207158d7c	post.logout.redirect.uris	+
da27507b-edfa-44f4-a2f0-a94225bea092	post.logout.redirect.uris	+
da27507b-edfa-44f4-a2f0-a94225bea092	pkce.code.challenge.method	S256
faf611cc-6822-4e45-a870-a0b9360b785c	post.logout.redirect.uris	+
faf611cc-6822-4e45-a870-a0b9360b785c	pkce.code.challenge.method	S256
11ada4c6-3523-4a02-a7cf-2c3f06c7e176	post.logout.redirect.uris	+
c123e002-011b-4645-ab5a-10d4b9929eff	pkce.code.challenge.method	S256
c123e002-011b-4645-ab5a-10d4b9929eff	post.logout.redirect.uris	+
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
04fad609-0efa-40a2-be89-17d15e0cdc47	offline_access	50f476a7-f350-43ba-8b98-a206554bea56	OpenID Connect built-in scope: offline_access	openid-connect
e5e54977-7eab-4990-87a0-566bbba00a28	role_list	50f476a7-f350-43ba-8b98-a206554bea56	SAML role list	saml
56d80899-2a5f-461e-bb50-424fee17be16	profile	50f476a7-f350-43ba-8b98-a206554bea56	OpenID Connect built-in scope: profile	openid-connect
7ef4a463-d594-4c2b-a6e0-2bbd1571e26d	email	50f476a7-f350-43ba-8b98-a206554bea56	OpenID Connect built-in scope: email	openid-connect
96cd270b-7416-44a2-8415-58a5c024e377	address	50f476a7-f350-43ba-8b98-a206554bea56	OpenID Connect built-in scope: address	openid-connect
e27253aa-3610-4e97-aac6-b5a88162aa91	phone	50f476a7-f350-43ba-8b98-a206554bea56	OpenID Connect built-in scope: phone	openid-connect
c25c5113-088f-4c86-92d9-d5d01f0868f7	roles	50f476a7-f350-43ba-8b98-a206554bea56	OpenID Connect scope for add user roles to the access token	openid-connect
992ca06d-3a7b-4548-a6bd-ef237ffc5b77	web-origins	50f476a7-f350-43ba-8b98-a206554bea56	OpenID Connect scope for add allowed web origins to the access token	openid-connect
b6a79f3a-5e6d-4950-9e3c-abf3a56d2d95	microprofile-jwt	50f476a7-f350-43ba-8b98-a206554bea56	Microprofile - JWT built-in scope	openid-connect
21b2b516-cb04-400c-86ff-30df256cbe3a	acr	50f476a7-f350-43ba-8b98-a206554bea56	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
be4dbd84-12a7-4e80-a724-e978f538bc01	basic	50f476a7-f350-43ba-8b98-a206554bea56	OpenID Connect scope for add all basic claims to the token	openid-connect
404c21e9-aaf5-4982-bf23-ef149c7e200e	offline_access	2fc07f5a-9f12-47ad-8999-54ec21d06664	OpenID Connect built-in scope: offline_access	openid-connect
28983cdd-e6e4-4396-9943-f8a37f34c461	role_list	2fc07f5a-9f12-47ad-8999-54ec21d06664	SAML role list	saml
668bf349-0426-4c6f-becc-739acc709266	profile	2fc07f5a-9f12-47ad-8999-54ec21d06664	OpenID Connect built-in scope: profile	openid-connect
edde022c-b83b-4ecd-9c2c-9e739d615cde	email	2fc07f5a-9f12-47ad-8999-54ec21d06664	OpenID Connect built-in scope: email	openid-connect
b19faed9-8fd5-481a-92f7-80add32df9d9	address	2fc07f5a-9f12-47ad-8999-54ec21d06664	OpenID Connect built-in scope: address	openid-connect
3bcb8921-7c43-4de0-afb1-bb3824cfd8b0	phone	2fc07f5a-9f12-47ad-8999-54ec21d06664	OpenID Connect built-in scope: phone	openid-connect
4b3b68dd-ec00-41b3-9759-67badc56bb37	roles	2fc07f5a-9f12-47ad-8999-54ec21d06664	OpenID Connect scope for add user roles to the access token	openid-connect
bada85d6-c053-4101-8d0f-eda3c2568cbf	web-origins	2fc07f5a-9f12-47ad-8999-54ec21d06664	OpenID Connect scope for add allowed web origins to the access token	openid-connect
df7770fb-fd2d-49db-a646-dd97f34e8b6f	microprofile-jwt	2fc07f5a-9f12-47ad-8999-54ec21d06664	Microprofile - JWT built-in scope	openid-connect
388e2005-f8e4-45ff-9980-7c7485577ac1	acr	2fc07f5a-9f12-47ad-8999-54ec21d06664	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
4fa1b3b7-b92e-4909-ad74-dc55efe4737d	basic	2fc07f5a-9f12-47ad-8999-54ec21d06664	OpenID Connect scope for add all basic claims to the token	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
04fad609-0efa-40a2-be89-17d15e0cdc47	true	display.on.consent.screen
04fad609-0efa-40a2-be89-17d15e0cdc47	${offlineAccessScopeConsentText}	consent.screen.text
e5e54977-7eab-4990-87a0-566bbba00a28	true	display.on.consent.screen
e5e54977-7eab-4990-87a0-566bbba00a28	${samlRoleListScopeConsentText}	consent.screen.text
56d80899-2a5f-461e-bb50-424fee17be16	true	display.on.consent.screen
56d80899-2a5f-461e-bb50-424fee17be16	${profileScopeConsentText}	consent.screen.text
56d80899-2a5f-461e-bb50-424fee17be16	true	include.in.token.scope
7ef4a463-d594-4c2b-a6e0-2bbd1571e26d	true	display.on.consent.screen
7ef4a463-d594-4c2b-a6e0-2bbd1571e26d	${emailScopeConsentText}	consent.screen.text
7ef4a463-d594-4c2b-a6e0-2bbd1571e26d	true	include.in.token.scope
96cd270b-7416-44a2-8415-58a5c024e377	true	display.on.consent.screen
96cd270b-7416-44a2-8415-58a5c024e377	${addressScopeConsentText}	consent.screen.text
96cd270b-7416-44a2-8415-58a5c024e377	true	include.in.token.scope
e27253aa-3610-4e97-aac6-b5a88162aa91	true	display.on.consent.screen
e27253aa-3610-4e97-aac6-b5a88162aa91	${phoneScopeConsentText}	consent.screen.text
e27253aa-3610-4e97-aac6-b5a88162aa91	true	include.in.token.scope
c25c5113-088f-4c86-92d9-d5d01f0868f7	true	display.on.consent.screen
c25c5113-088f-4c86-92d9-d5d01f0868f7	${rolesScopeConsentText}	consent.screen.text
c25c5113-088f-4c86-92d9-d5d01f0868f7	false	include.in.token.scope
992ca06d-3a7b-4548-a6bd-ef237ffc5b77	false	display.on.consent.screen
992ca06d-3a7b-4548-a6bd-ef237ffc5b77		consent.screen.text
992ca06d-3a7b-4548-a6bd-ef237ffc5b77	false	include.in.token.scope
b6a79f3a-5e6d-4950-9e3c-abf3a56d2d95	false	display.on.consent.screen
b6a79f3a-5e6d-4950-9e3c-abf3a56d2d95	true	include.in.token.scope
21b2b516-cb04-400c-86ff-30df256cbe3a	false	display.on.consent.screen
21b2b516-cb04-400c-86ff-30df256cbe3a	false	include.in.token.scope
be4dbd84-12a7-4e80-a724-e978f538bc01	false	display.on.consent.screen
be4dbd84-12a7-4e80-a724-e978f538bc01	false	include.in.token.scope
404c21e9-aaf5-4982-bf23-ef149c7e200e	true	display.on.consent.screen
404c21e9-aaf5-4982-bf23-ef149c7e200e	${offlineAccessScopeConsentText}	consent.screen.text
28983cdd-e6e4-4396-9943-f8a37f34c461	true	display.on.consent.screen
28983cdd-e6e4-4396-9943-f8a37f34c461	${samlRoleListScopeConsentText}	consent.screen.text
668bf349-0426-4c6f-becc-739acc709266	true	display.on.consent.screen
668bf349-0426-4c6f-becc-739acc709266	${profileScopeConsentText}	consent.screen.text
668bf349-0426-4c6f-becc-739acc709266	true	include.in.token.scope
edde022c-b83b-4ecd-9c2c-9e739d615cde	true	display.on.consent.screen
edde022c-b83b-4ecd-9c2c-9e739d615cde	${emailScopeConsentText}	consent.screen.text
edde022c-b83b-4ecd-9c2c-9e739d615cde	true	include.in.token.scope
b19faed9-8fd5-481a-92f7-80add32df9d9	true	display.on.consent.screen
b19faed9-8fd5-481a-92f7-80add32df9d9	${addressScopeConsentText}	consent.screen.text
b19faed9-8fd5-481a-92f7-80add32df9d9	true	include.in.token.scope
3bcb8921-7c43-4de0-afb1-bb3824cfd8b0	true	display.on.consent.screen
3bcb8921-7c43-4de0-afb1-bb3824cfd8b0	${phoneScopeConsentText}	consent.screen.text
3bcb8921-7c43-4de0-afb1-bb3824cfd8b0	true	include.in.token.scope
4b3b68dd-ec00-41b3-9759-67badc56bb37	true	display.on.consent.screen
4b3b68dd-ec00-41b3-9759-67badc56bb37	${rolesScopeConsentText}	consent.screen.text
4b3b68dd-ec00-41b3-9759-67badc56bb37	false	include.in.token.scope
bada85d6-c053-4101-8d0f-eda3c2568cbf	false	display.on.consent.screen
bada85d6-c053-4101-8d0f-eda3c2568cbf		consent.screen.text
bada85d6-c053-4101-8d0f-eda3c2568cbf	false	include.in.token.scope
df7770fb-fd2d-49db-a646-dd97f34e8b6f	false	display.on.consent.screen
df7770fb-fd2d-49db-a646-dd97f34e8b6f	true	include.in.token.scope
388e2005-f8e4-45ff-9980-7c7485577ac1	false	display.on.consent.screen
388e2005-f8e4-45ff-9980-7c7485577ac1	false	include.in.token.scope
4fa1b3b7-b92e-4909-ad74-dc55efe4737d	false	display.on.consent.screen
4fa1b3b7-b92e-4909-ad74-dc55efe4737d	false	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
bfcbc2d9-28f2-41b3-ab8f-e3ec970dd844	7ef4a463-d594-4c2b-a6e0-2bbd1571e26d	t
bfcbc2d9-28f2-41b3-ab8f-e3ec970dd844	21b2b516-cb04-400c-86ff-30df256cbe3a	t
bfcbc2d9-28f2-41b3-ab8f-e3ec970dd844	992ca06d-3a7b-4548-a6bd-ef237ffc5b77	t
bfcbc2d9-28f2-41b3-ab8f-e3ec970dd844	c25c5113-088f-4c86-92d9-d5d01f0868f7	t
bfcbc2d9-28f2-41b3-ab8f-e3ec970dd844	56d80899-2a5f-461e-bb50-424fee17be16	t
bfcbc2d9-28f2-41b3-ab8f-e3ec970dd844	be4dbd84-12a7-4e80-a724-e978f538bc01	t
bfcbc2d9-28f2-41b3-ab8f-e3ec970dd844	96cd270b-7416-44a2-8415-58a5c024e377	f
bfcbc2d9-28f2-41b3-ab8f-e3ec970dd844	04fad609-0efa-40a2-be89-17d15e0cdc47	f
bfcbc2d9-28f2-41b3-ab8f-e3ec970dd844	e27253aa-3610-4e97-aac6-b5a88162aa91	f
bfcbc2d9-28f2-41b3-ab8f-e3ec970dd844	b6a79f3a-5e6d-4950-9e3c-abf3a56d2d95	f
dda90977-935d-46a5-9869-cf36a2ef0e96	7ef4a463-d594-4c2b-a6e0-2bbd1571e26d	t
dda90977-935d-46a5-9869-cf36a2ef0e96	21b2b516-cb04-400c-86ff-30df256cbe3a	t
dda90977-935d-46a5-9869-cf36a2ef0e96	992ca06d-3a7b-4548-a6bd-ef237ffc5b77	t
dda90977-935d-46a5-9869-cf36a2ef0e96	c25c5113-088f-4c86-92d9-d5d01f0868f7	t
dda90977-935d-46a5-9869-cf36a2ef0e96	56d80899-2a5f-461e-bb50-424fee17be16	t
dda90977-935d-46a5-9869-cf36a2ef0e96	be4dbd84-12a7-4e80-a724-e978f538bc01	t
dda90977-935d-46a5-9869-cf36a2ef0e96	96cd270b-7416-44a2-8415-58a5c024e377	f
dda90977-935d-46a5-9869-cf36a2ef0e96	04fad609-0efa-40a2-be89-17d15e0cdc47	f
dda90977-935d-46a5-9869-cf36a2ef0e96	e27253aa-3610-4e97-aac6-b5a88162aa91	f
dda90977-935d-46a5-9869-cf36a2ef0e96	b6a79f3a-5e6d-4950-9e3c-abf3a56d2d95	f
4376b76c-b690-4c69-87ce-fa225ed58030	7ef4a463-d594-4c2b-a6e0-2bbd1571e26d	t
4376b76c-b690-4c69-87ce-fa225ed58030	21b2b516-cb04-400c-86ff-30df256cbe3a	t
4376b76c-b690-4c69-87ce-fa225ed58030	992ca06d-3a7b-4548-a6bd-ef237ffc5b77	t
4376b76c-b690-4c69-87ce-fa225ed58030	c25c5113-088f-4c86-92d9-d5d01f0868f7	t
4376b76c-b690-4c69-87ce-fa225ed58030	56d80899-2a5f-461e-bb50-424fee17be16	t
4376b76c-b690-4c69-87ce-fa225ed58030	be4dbd84-12a7-4e80-a724-e978f538bc01	t
4376b76c-b690-4c69-87ce-fa225ed58030	96cd270b-7416-44a2-8415-58a5c024e377	f
4376b76c-b690-4c69-87ce-fa225ed58030	04fad609-0efa-40a2-be89-17d15e0cdc47	f
4376b76c-b690-4c69-87ce-fa225ed58030	e27253aa-3610-4e97-aac6-b5a88162aa91	f
4376b76c-b690-4c69-87ce-fa225ed58030	b6a79f3a-5e6d-4950-9e3c-abf3a56d2d95	f
807aea33-e235-4992-9b80-98f9cf3cef24	7ef4a463-d594-4c2b-a6e0-2bbd1571e26d	t
807aea33-e235-4992-9b80-98f9cf3cef24	21b2b516-cb04-400c-86ff-30df256cbe3a	t
807aea33-e235-4992-9b80-98f9cf3cef24	992ca06d-3a7b-4548-a6bd-ef237ffc5b77	t
807aea33-e235-4992-9b80-98f9cf3cef24	c25c5113-088f-4c86-92d9-d5d01f0868f7	t
807aea33-e235-4992-9b80-98f9cf3cef24	56d80899-2a5f-461e-bb50-424fee17be16	t
807aea33-e235-4992-9b80-98f9cf3cef24	be4dbd84-12a7-4e80-a724-e978f538bc01	t
807aea33-e235-4992-9b80-98f9cf3cef24	96cd270b-7416-44a2-8415-58a5c024e377	f
807aea33-e235-4992-9b80-98f9cf3cef24	04fad609-0efa-40a2-be89-17d15e0cdc47	f
807aea33-e235-4992-9b80-98f9cf3cef24	e27253aa-3610-4e97-aac6-b5a88162aa91	f
807aea33-e235-4992-9b80-98f9cf3cef24	b6a79f3a-5e6d-4950-9e3c-abf3a56d2d95	f
0d818e3a-2fb1-49da-938d-757867de28a5	7ef4a463-d594-4c2b-a6e0-2bbd1571e26d	t
0d818e3a-2fb1-49da-938d-757867de28a5	21b2b516-cb04-400c-86ff-30df256cbe3a	t
0d818e3a-2fb1-49da-938d-757867de28a5	992ca06d-3a7b-4548-a6bd-ef237ffc5b77	t
0d818e3a-2fb1-49da-938d-757867de28a5	c25c5113-088f-4c86-92d9-d5d01f0868f7	t
0d818e3a-2fb1-49da-938d-757867de28a5	56d80899-2a5f-461e-bb50-424fee17be16	t
0d818e3a-2fb1-49da-938d-757867de28a5	be4dbd84-12a7-4e80-a724-e978f538bc01	t
0d818e3a-2fb1-49da-938d-757867de28a5	96cd270b-7416-44a2-8415-58a5c024e377	f
0d818e3a-2fb1-49da-938d-757867de28a5	04fad609-0efa-40a2-be89-17d15e0cdc47	f
0d818e3a-2fb1-49da-938d-757867de28a5	e27253aa-3610-4e97-aac6-b5a88162aa91	f
0d818e3a-2fb1-49da-938d-757867de28a5	b6a79f3a-5e6d-4950-9e3c-abf3a56d2d95	f
88de62f1-8110-4f86-95b6-fb4df82ef163	7ef4a463-d594-4c2b-a6e0-2bbd1571e26d	t
88de62f1-8110-4f86-95b6-fb4df82ef163	21b2b516-cb04-400c-86ff-30df256cbe3a	t
88de62f1-8110-4f86-95b6-fb4df82ef163	992ca06d-3a7b-4548-a6bd-ef237ffc5b77	t
88de62f1-8110-4f86-95b6-fb4df82ef163	c25c5113-088f-4c86-92d9-d5d01f0868f7	t
88de62f1-8110-4f86-95b6-fb4df82ef163	56d80899-2a5f-461e-bb50-424fee17be16	t
88de62f1-8110-4f86-95b6-fb4df82ef163	be4dbd84-12a7-4e80-a724-e978f538bc01	t
88de62f1-8110-4f86-95b6-fb4df82ef163	96cd270b-7416-44a2-8415-58a5c024e377	f
88de62f1-8110-4f86-95b6-fb4df82ef163	04fad609-0efa-40a2-be89-17d15e0cdc47	f
88de62f1-8110-4f86-95b6-fb4df82ef163	e27253aa-3610-4e97-aac6-b5a88162aa91	f
88de62f1-8110-4f86-95b6-fb4df82ef163	b6a79f3a-5e6d-4950-9e3c-abf3a56d2d95	f
120af667-e73e-4e08-a4e0-4d0207158d7c	4fa1b3b7-b92e-4909-ad74-dc55efe4737d	t
120af667-e73e-4e08-a4e0-4d0207158d7c	668bf349-0426-4c6f-becc-739acc709266	t
120af667-e73e-4e08-a4e0-4d0207158d7c	388e2005-f8e4-45ff-9980-7c7485577ac1	t
120af667-e73e-4e08-a4e0-4d0207158d7c	edde022c-b83b-4ecd-9c2c-9e739d615cde	t
120af667-e73e-4e08-a4e0-4d0207158d7c	4b3b68dd-ec00-41b3-9759-67badc56bb37	t
120af667-e73e-4e08-a4e0-4d0207158d7c	bada85d6-c053-4101-8d0f-eda3c2568cbf	t
120af667-e73e-4e08-a4e0-4d0207158d7c	df7770fb-fd2d-49db-a646-dd97f34e8b6f	f
120af667-e73e-4e08-a4e0-4d0207158d7c	3bcb8921-7c43-4de0-afb1-bb3824cfd8b0	f
120af667-e73e-4e08-a4e0-4d0207158d7c	404c21e9-aaf5-4982-bf23-ef149c7e200e	f
120af667-e73e-4e08-a4e0-4d0207158d7c	b19faed9-8fd5-481a-92f7-80add32df9d9	f
da27507b-edfa-44f4-a2f0-a94225bea092	4fa1b3b7-b92e-4909-ad74-dc55efe4737d	t
da27507b-edfa-44f4-a2f0-a94225bea092	668bf349-0426-4c6f-becc-739acc709266	t
da27507b-edfa-44f4-a2f0-a94225bea092	388e2005-f8e4-45ff-9980-7c7485577ac1	t
da27507b-edfa-44f4-a2f0-a94225bea092	edde022c-b83b-4ecd-9c2c-9e739d615cde	t
da27507b-edfa-44f4-a2f0-a94225bea092	4b3b68dd-ec00-41b3-9759-67badc56bb37	t
da27507b-edfa-44f4-a2f0-a94225bea092	bada85d6-c053-4101-8d0f-eda3c2568cbf	t
da27507b-edfa-44f4-a2f0-a94225bea092	df7770fb-fd2d-49db-a646-dd97f34e8b6f	f
da27507b-edfa-44f4-a2f0-a94225bea092	3bcb8921-7c43-4de0-afb1-bb3824cfd8b0	f
da27507b-edfa-44f4-a2f0-a94225bea092	404c21e9-aaf5-4982-bf23-ef149c7e200e	f
da27507b-edfa-44f4-a2f0-a94225bea092	b19faed9-8fd5-481a-92f7-80add32df9d9	f
cf236ce0-a2d3-4125-aa9a-a9746eef3272	4fa1b3b7-b92e-4909-ad74-dc55efe4737d	t
cf236ce0-a2d3-4125-aa9a-a9746eef3272	668bf349-0426-4c6f-becc-739acc709266	t
cf236ce0-a2d3-4125-aa9a-a9746eef3272	388e2005-f8e4-45ff-9980-7c7485577ac1	t
cf236ce0-a2d3-4125-aa9a-a9746eef3272	edde022c-b83b-4ecd-9c2c-9e739d615cde	t
cf236ce0-a2d3-4125-aa9a-a9746eef3272	4b3b68dd-ec00-41b3-9759-67badc56bb37	t
cf236ce0-a2d3-4125-aa9a-a9746eef3272	bada85d6-c053-4101-8d0f-eda3c2568cbf	t
cf236ce0-a2d3-4125-aa9a-a9746eef3272	df7770fb-fd2d-49db-a646-dd97f34e8b6f	f
cf236ce0-a2d3-4125-aa9a-a9746eef3272	3bcb8921-7c43-4de0-afb1-bb3824cfd8b0	f
cf236ce0-a2d3-4125-aa9a-a9746eef3272	404c21e9-aaf5-4982-bf23-ef149c7e200e	f
cf236ce0-a2d3-4125-aa9a-a9746eef3272	b19faed9-8fd5-481a-92f7-80add32df9d9	f
4884a5cc-31e3-4050-a98a-bc96805cfc3a	4fa1b3b7-b92e-4909-ad74-dc55efe4737d	t
4884a5cc-31e3-4050-a98a-bc96805cfc3a	668bf349-0426-4c6f-becc-739acc709266	t
4884a5cc-31e3-4050-a98a-bc96805cfc3a	388e2005-f8e4-45ff-9980-7c7485577ac1	t
4884a5cc-31e3-4050-a98a-bc96805cfc3a	edde022c-b83b-4ecd-9c2c-9e739d615cde	t
4884a5cc-31e3-4050-a98a-bc96805cfc3a	4b3b68dd-ec00-41b3-9759-67badc56bb37	t
4884a5cc-31e3-4050-a98a-bc96805cfc3a	bada85d6-c053-4101-8d0f-eda3c2568cbf	t
4884a5cc-31e3-4050-a98a-bc96805cfc3a	df7770fb-fd2d-49db-a646-dd97f34e8b6f	f
4884a5cc-31e3-4050-a98a-bc96805cfc3a	3bcb8921-7c43-4de0-afb1-bb3824cfd8b0	f
4884a5cc-31e3-4050-a98a-bc96805cfc3a	404c21e9-aaf5-4982-bf23-ef149c7e200e	f
4884a5cc-31e3-4050-a98a-bc96805cfc3a	b19faed9-8fd5-481a-92f7-80add32df9d9	f
47f0efe6-666f-428e-985a-c4b2770df830	4fa1b3b7-b92e-4909-ad74-dc55efe4737d	t
47f0efe6-666f-428e-985a-c4b2770df830	668bf349-0426-4c6f-becc-739acc709266	t
47f0efe6-666f-428e-985a-c4b2770df830	388e2005-f8e4-45ff-9980-7c7485577ac1	t
47f0efe6-666f-428e-985a-c4b2770df830	edde022c-b83b-4ecd-9c2c-9e739d615cde	t
47f0efe6-666f-428e-985a-c4b2770df830	4b3b68dd-ec00-41b3-9759-67badc56bb37	t
47f0efe6-666f-428e-985a-c4b2770df830	bada85d6-c053-4101-8d0f-eda3c2568cbf	t
47f0efe6-666f-428e-985a-c4b2770df830	df7770fb-fd2d-49db-a646-dd97f34e8b6f	f
47f0efe6-666f-428e-985a-c4b2770df830	3bcb8921-7c43-4de0-afb1-bb3824cfd8b0	f
47f0efe6-666f-428e-985a-c4b2770df830	404c21e9-aaf5-4982-bf23-ef149c7e200e	f
47f0efe6-666f-428e-985a-c4b2770df830	b19faed9-8fd5-481a-92f7-80add32df9d9	f
faf611cc-6822-4e45-a870-a0b9360b785c	4fa1b3b7-b92e-4909-ad74-dc55efe4737d	t
faf611cc-6822-4e45-a870-a0b9360b785c	668bf349-0426-4c6f-becc-739acc709266	t
faf611cc-6822-4e45-a870-a0b9360b785c	388e2005-f8e4-45ff-9980-7c7485577ac1	t
faf611cc-6822-4e45-a870-a0b9360b785c	edde022c-b83b-4ecd-9c2c-9e739d615cde	t
faf611cc-6822-4e45-a870-a0b9360b785c	4b3b68dd-ec00-41b3-9759-67badc56bb37	t
faf611cc-6822-4e45-a870-a0b9360b785c	bada85d6-c053-4101-8d0f-eda3c2568cbf	t
faf611cc-6822-4e45-a870-a0b9360b785c	df7770fb-fd2d-49db-a646-dd97f34e8b6f	f
faf611cc-6822-4e45-a870-a0b9360b785c	3bcb8921-7c43-4de0-afb1-bb3824cfd8b0	f
faf611cc-6822-4e45-a870-a0b9360b785c	404c21e9-aaf5-4982-bf23-ef149c7e200e	f
faf611cc-6822-4e45-a870-a0b9360b785c	b19faed9-8fd5-481a-92f7-80add32df9d9	f
11ada4c6-3523-4a02-a7cf-2c3f06c7e176	4fa1b3b7-b92e-4909-ad74-dc55efe4737d	t
11ada4c6-3523-4a02-a7cf-2c3f06c7e176	668bf349-0426-4c6f-becc-739acc709266	t
11ada4c6-3523-4a02-a7cf-2c3f06c7e176	388e2005-f8e4-45ff-9980-7c7485577ac1	t
11ada4c6-3523-4a02-a7cf-2c3f06c7e176	edde022c-b83b-4ecd-9c2c-9e739d615cde	t
11ada4c6-3523-4a02-a7cf-2c3f06c7e176	4b3b68dd-ec00-41b3-9759-67badc56bb37	t
11ada4c6-3523-4a02-a7cf-2c3f06c7e176	bada85d6-c053-4101-8d0f-eda3c2568cbf	t
11ada4c6-3523-4a02-a7cf-2c3f06c7e176	df7770fb-fd2d-49db-a646-dd97f34e8b6f	f
11ada4c6-3523-4a02-a7cf-2c3f06c7e176	3bcb8921-7c43-4de0-afb1-bb3824cfd8b0	f
11ada4c6-3523-4a02-a7cf-2c3f06c7e176	404c21e9-aaf5-4982-bf23-ef149c7e200e	f
11ada4c6-3523-4a02-a7cf-2c3f06c7e176	b19faed9-8fd5-481a-92f7-80add32df9d9	f
c123e002-011b-4645-ab5a-10d4b9929eff	4fa1b3b7-b92e-4909-ad74-dc55efe4737d	t
c123e002-011b-4645-ab5a-10d4b9929eff	668bf349-0426-4c6f-becc-739acc709266	t
c123e002-011b-4645-ab5a-10d4b9929eff	388e2005-f8e4-45ff-9980-7c7485577ac1	t
c123e002-011b-4645-ab5a-10d4b9929eff	edde022c-b83b-4ecd-9c2c-9e739d615cde	t
c123e002-011b-4645-ab5a-10d4b9929eff	4b3b68dd-ec00-41b3-9759-67badc56bb37	t
c123e002-011b-4645-ab5a-10d4b9929eff	bada85d6-c053-4101-8d0f-eda3c2568cbf	t
c123e002-011b-4645-ab5a-10d4b9929eff	df7770fb-fd2d-49db-a646-dd97f34e8b6f	f
c123e002-011b-4645-ab5a-10d4b9929eff	3bcb8921-7c43-4de0-afb1-bb3824cfd8b0	f
c123e002-011b-4645-ab5a-10d4b9929eff	404c21e9-aaf5-4982-bf23-ef149c7e200e	f
c123e002-011b-4645-ab5a-10d4b9929eff	b19faed9-8fd5-481a-92f7-80add32df9d9	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
04fad609-0efa-40a2-be89-17d15e0cdc47	51551348-4ef2-41ce-b4a7-2de5a84c200d
404c21e9-aaf5-4982-bf23-ef149c7e200e	a3bdece0-2d4f-4de5-bd75-15001b843e6f
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
81779c0e-7f80-4d2c-a671-751c42e38418	Trusted Hosts	50f476a7-f350-43ba-8b98-a206554bea56	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	50f476a7-f350-43ba-8b98-a206554bea56	anonymous
7e6468a7-c196-43cf-92f6-f46aaf0497fd	Consent Required	50f476a7-f350-43ba-8b98-a206554bea56	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	50f476a7-f350-43ba-8b98-a206554bea56	anonymous
a5ac4372-10d5-4c9c-b50f-ae3b247dd4fb	Full Scope Disabled	50f476a7-f350-43ba-8b98-a206554bea56	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	50f476a7-f350-43ba-8b98-a206554bea56	anonymous
50c96479-80e3-4d3b-8e09-74e4eb180ba9	Max Clients Limit	50f476a7-f350-43ba-8b98-a206554bea56	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	50f476a7-f350-43ba-8b98-a206554bea56	anonymous
ef4fa5c8-1118-49ba-81ad-7a554692f01d	Allowed Protocol Mapper Types	50f476a7-f350-43ba-8b98-a206554bea56	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	50f476a7-f350-43ba-8b98-a206554bea56	anonymous
defb8177-3ba0-418f-b29a-83a55299c667	Allowed Client Scopes	50f476a7-f350-43ba-8b98-a206554bea56	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	50f476a7-f350-43ba-8b98-a206554bea56	anonymous
ca1b9e4c-2064-44e2-a8f0-39b3528106cb	Allowed Protocol Mapper Types	50f476a7-f350-43ba-8b98-a206554bea56	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	50f476a7-f350-43ba-8b98-a206554bea56	authenticated
f4ed1057-aa81-4774-9bc0-63d478e1e546	Allowed Client Scopes	50f476a7-f350-43ba-8b98-a206554bea56	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	50f476a7-f350-43ba-8b98-a206554bea56	authenticated
df53b09d-05e1-4751-b118-060f316c97ba	rsa-generated	50f476a7-f350-43ba-8b98-a206554bea56	rsa-generated	org.keycloak.keys.KeyProvider	50f476a7-f350-43ba-8b98-a206554bea56	\N
d4f4e15b-3f69-4340-ae31-3723e9fc44e7	rsa-enc-generated	50f476a7-f350-43ba-8b98-a206554bea56	rsa-enc-generated	org.keycloak.keys.KeyProvider	50f476a7-f350-43ba-8b98-a206554bea56	\N
ec4bbd4c-77f7-4b4a-b033-aa153b217cad	hmac-generated-hs512	50f476a7-f350-43ba-8b98-a206554bea56	hmac-generated	org.keycloak.keys.KeyProvider	50f476a7-f350-43ba-8b98-a206554bea56	\N
9b45f15c-967f-43d8-bc43-bd5e8bc3ffd9	aes-generated	50f476a7-f350-43ba-8b98-a206554bea56	aes-generated	org.keycloak.keys.KeyProvider	50f476a7-f350-43ba-8b98-a206554bea56	\N
72c97651-135e-4e00-bca4-58a8c34a8049	\N	50f476a7-f350-43ba-8b98-a206554bea56	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	50f476a7-f350-43ba-8b98-a206554bea56	\N
1581aa6a-b7b4-4e2e-8331-cec1612e3ee5	rsa-generated	2fc07f5a-9f12-47ad-8999-54ec21d06664	rsa-generated	org.keycloak.keys.KeyProvider	2fc07f5a-9f12-47ad-8999-54ec21d06664	\N
5d9f56ef-b260-4c93-8bc6-4cd55a9c345e	rsa-enc-generated	2fc07f5a-9f12-47ad-8999-54ec21d06664	rsa-enc-generated	org.keycloak.keys.KeyProvider	2fc07f5a-9f12-47ad-8999-54ec21d06664	\N
caaac2a7-677c-4b3f-8cd0-864078a40b26	hmac-generated-hs512	2fc07f5a-9f12-47ad-8999-54ec21d06664	hmac-generated	org.keycloak.keys.KeyProvider	2fc07f5a-9f12-47ad-8999-54ec21d06664	\N
9f924895-eec1-4a9e-b0d6-66a407da47cc	aes-generated	2fc07f5a-9f12-47ad-8999-54ec21d06664	aes-generated	org.keycloak.keys.KeyProvider	2fc07f5a-9f12-47ad-8999-54ec21d06664	\N
9fcb7f55-ce68-43c3-88f5-4714e5a89f7e	Trusted Hosts	2fc07f5a-9f12-47ad-8999-54ec21d06664	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2fc07f5a-9f12-47ad-8999-54ec21d06664	anonymous
c0a48f57-525c-4889-8a61-2594a4fa412b	Consent Required	2fc07f5a-9f12-47ad-8999-54ec21d06664	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2fc07f5a-9f12-47ad-8999-54ec21d06664	anonymous
faed57db-5d83-4294-8307-1ec894b05136	Full Scope Disabled	2fc07f5a-9f12-47ad-8999-54ec21d06664	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2fc07f5a-9f12-47ad-8999-54ec21d06664	anonymous
782e26f2-9ec7-474a-9193-f88e646f3650	Max Clients Limit	2fc07f5a-9f12-47ad-8999-54ec21d06664	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2fc07f5a-9f12-47ad-8999-54ec21d06664	anonymous
cf92a382-3fb9-426a-8b1f-fb9bc4515bdc	Allowed Protocol Mapper Types	2fc07f5a-9f12-47ad-8999-54ec21d06664	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2fc07f5a-9f12-47ad-8999-54ec21d06664	anonymous
21100325-8473-4a91-9c36-4494db77854f	Allowed Client Scopes	2fc07f5a-9f12-47ad-8999-54ec21d06664	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2fc07f5a-9f12-47ad-8999-54ec21d06664	anonymous
78f83168-caab-4331-8424-eabc013e74cc	Allowed Protocol Mapper Types	2fc07f5a-9f12-47ad-8999-54ec21d06664	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2fc07f5a-9f12-47ad-8999-54ec21d06664	authenticated
c23195a8-8077-4a0e-8dee-b5dbd8818607	Allowed Client Scopes	2fc07f5a-9f12-47ad-8999-54ec21d06664	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2fc07f5a-9f12-47ad-8999-54ec21d06664	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
9a64dca5-f1f3-4304-a7e3-a7c91d748144	ef4fa5c8-1118-49ba-81ad-7a554692f01d	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
11575ebc-854b-408e-b335-fa1caf67e3e4	ef4fa5c8-1118-49ba-81ad-7a554692f01d	allowed-protocol-mapper-types	saml-user-attribute-mapper
59dc7ef3-8653-4d39-9b97-9bcfb0ed4c19	ef4fa5c8-1118-49ba-81ad-7a554692f01d	allowed-protocol-mapper-types	oidc-full-name-mapper
fdec317c-571e-427d-99a3-3dfd288965b6	ef4fa5c8-1118-49ba-81ad-7a554692f01d	allowed-protocol-mapper-types	saml-user-property-mapper
ade4fc27-82d2-4ab1-8c3d-d8c15136a226	ef4fa5c8-1118-49ba-81ad-7a554692f01d	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
60716f51-bac2-424b-aeb6-ee5456283a8d	ef4fa5c8-1118-49ba-81ad-7a554692f01d	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
47c84a60-43a2-404b-ba8f-d611b31c5eb7	ef4fa5c8-1118-49ba-81ad-7a554692f01d	allowed-protocol-mapper-types	saml-role-list-mapper
631a7def-fa83-416f-b2c5-e6fcb5b66ba6	ef4fa5c8-1118-49ba-81ad-7a554692f01d	allowed-protocol-mapper-types	oidc-address-mapper
14164204-18eb-4e61-8b7c-188ba2073975	50c96479-80e3-4d3b-8e09-74e4eb180ba9	max-clients	200
a19c0545-bfc8-4c8b-aed6-404e035f5a20	f4ed1057-aa81-4774-9bc0-63d478e1e546	allow-default-scopes	true
da1bcb1d-fc5c-4800-a594-790d408fcbe1	defb8177-3ba0-418f-b29a-83a55299c667	allow-default-scopes	true
beabafbd-6483-46c1-84c1-d885bcf66eb4	81779c0e-7f80-4d2c-a671-751c42e38418	client-uris-must-match	true
01b8a14c-f721-49d9-a8d1-25161ce4bc7a	81779c0e-7f80-4d2c-a671-751c42e38418	host-sending-registration-request-must-match	true
2f6f5112-e025-4887-a510-377eb393ee70	ca1b9e4c-2064-44e2-a8f0-39b3528106cb	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
3b41081a-a717-45f4-a244-5a38d79ad09d	ca1b9e4c-2064-44e2-a8f0-39b3528106cb	allowed-protocol-mapper-types	saml-user-attribute-mapper
d64c1abc-f84f-48bd-aeec-79aa4cc67397	ca1b9e4c-2064-44e2-a8f0-39b3528106cb	allowed-protocol-mapper-types	oidc-full-name-mapper
35064dbe-359a-412b-95c5-b3b7cd482c05	ca1b9e4c-2064-44e2-a8f0-39b3528106cb	allowed-protocol-mapper-types	saml-user-property-mapper
f5d544d2-f58a-4376-8db3-08511d34e720	ca1b9e4c-2064-44e2-a8f0-39b3528106cb	allowed-protocol-mapper-types	saml-role-list-mapper
19cb6741-24c0-41ee-93a0-8cca291a3382	ca1b9e4c-2064-44e2-a8f0-39b3528106cb	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
fc4ffda2-54a9-4e90-b39f-a03e53661031	ca1b9e4c-2064-44e2-a8f0-39b3528106cb	allowed-protocol-mapper-types	oidc-address-mapper
235293d5-da0b-4793-9cef-0e31dc90a530	ca1b9e4c-2064-44e2-a8f0-39b3528106cb	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
850319ab-75a7-4b23-a9bd-cff4fb1efcc9	ec4bbd4c-77f7-4b4a-b033-aa153b217cad	priority	100
c5396b75-3049-4939-9c1e-3e4cbb6b06e4	ec4bbd4c-77f7-4b4a-b033-aa153b217cad	kid	4ba83750-0899-4446-8efc-e2701e4c14b4
b62ed8e9-f975-41b9-8800-3786d8482d4d	ec4bbd4c-77f7-4b4a-b033-aa153b217cad	algorithm	HS512
5cb08ba3-071f-4010-9388-abaa9cf03107	ec4bbd4c-77f7-4b4a-b033-aa153b217cad	secret	T4Sg46jYwGubYgLZ71e7Ka4Hri3s-1NEM7ucZ4aYx5UUuNlUFGjpM_q0Wj4T7motRdZWJddSATqIC3RxpNEay49iCxqQVdDJmzQHbnrqMSO1bwmGpVzJmp6gG4W4S-CeQxZHkIsE2TJLjaTyrLvEzUeaodcP8HG-Inw4RJhodKg
f5c9f3b5-e3d2-4897-bb42-86592a321a56	d4f4e15b-3f69-4340-ae31-3723e9fc44e7	keyUse	ENC
5a6674b3-dd8d-4b7b-acc2-c9ba129bc94a	d4f4e15b-3f69-4340-ae31-3723e9fc44e7	priority	100
692e61c0-809c-4043-90ec-dbbe45a0724d	d4f4e15b-3f69-4340-ae31-3723e9fc44e7	privateKey	MIIEogIBAAKCAQEAwDkWZ0g2yisnLmoDYhO6CtANul2m+KiiWRmmPYeQxan0UKOpeCAnHq2LZi26GgJSm3lsFgxvCbtTwuNPDPb251eXH5MRQXPMP04jW+Qs3GnfbVgu0An3JEYMitw+VSSMMMJHQDKy25g/u6WZCfiJQii6dOgMY7YAkpiFFw4YFm8/zsvoziOxsukCI5QVqjhSuCnKY4SVWbqPhVh3aw/tABzVm0cPPI41Zr302zdb96KVb+uRVgKsgv6zy7ccWfjCGj7mPKc0LREWBSUcWZ0+ENzsNTC7NDkZAzJ9KqAzYxdP3fe4jj30HU7ZpWvrMlEu86kSF76JNPasdZdixF7y8QIDAQABAoIBAAUBN4EcPeOeTgMvsBjcn0pqx6tjhtZl5Zw2RmrHCHuXr4xt8Rqh6QLWd+ZYKHFG6t8GFqIC/t0dAH2hgiG58wxrmRFcYzr2CIpZaXhEr5pUM1oFzWo4kt5h6IUGXk/Eh4CO07YV29b11tWhkSN+Uhc5N5RAT8TvgdekmvUntnQsXl/mYg2HDvlOHHQbuFRKsCokPMoZPEJ5ROtOPMgrppVVhW2Ejk7Pe0J0Cl5QI0YWYrE2bUGVZKZWQv1791Oci7B8oVe4eo45PVY1v/7jjTx85WTtFlJiLSb2q/qOMBwDM8K44Rp1Bc4cG288nAckV4zm3I2yI57DcrAJJaYud0ECgYEA+kMiAL4/DCHSuX2yIYOASEWqMEonWjy4cSdXvmS6FLF0wsXEzq8ODUbw3jUOJ/WHVuR3kY1WNcRifSKvajbfiTnYRjlYd5dghMUxbs1KkEcP6P6NdRzwYidDvaTuqw1i0+jMa5Y6Hd9MNMFLnLet/4XH2AO+2j8DvL6bn8L10TkCgYEAxKFN5UZjGKJ6Sh2Hq6Kj9+tPzY8Ij4X/2/fPMy/6g5fOHeFdEjBQYwum9TCDFSsdk+v0QP68ocsgPX/tuBoEEqoK1SuxNuc8grrDSaH+vmK1+cnLWCyDcgZROdyve4CRD7KpAFp3HryMVt/RmfsoNRgAUIyEtkbaw5Vm1HWqh3kCgYAbrXEFRAUVAmibuxsIOdLmK043KPxRLoX3fbJmjB1ITJftMpIhiZq0PTRGXvfB05W0NnBC2K7AI4gA7uUXihoOwyb4HT97enJiPKzK5Elqy3EnA4ABg8HSGSWUw7jhkglsBkMVYvfqddenvfjuzCGiMNl5OnDREkcHiM0NTjKBgQKBgCYwDajRmr1WENoEEi1LUPz9Pmp1tPvq0l4uKpeOYeDcwrMa6bB2oaYaxTopScv6q6vmz3EwCAKEKKbJCaoPo2rci24LJke7cQ0SqIrMY2UmVqFEh7GAM6cZgvzx10LtHT8nO5tN9oSJqdfVcCevl4d4Oddq8vtTl3kUsvvgPlZBAoGAaJ2TYoYrxiizQrx9wpE8R848t0nIOVkArhFm8WGwoELYyQPDu9+nEy4Jbz+X8TRDZbT/XMn+logq5exGz2Cmgd5eby7DHYVFhGxvYgN3GwlKMl3VTQPD5yMY4PmPCZR7imnsPX2McZ2QSj9wYzTkVoK4sLcaEeMn7N4gMsxLcNs=
ac5e6ca0-fc7f-4071-8198-884749923c0c	d4f4e15b-3f69-4340-ae31-3723e9fc44e7	certificate	MIICmzCCAYMCBgGYoso5vDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwODEzMDkzNTE4WhcNMzUwODEzMDkzNjU4WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDAORZnSDbKKycuagNiE7oK0A26Xab4qKJZGaY9h5DFqfRQo6l4ICcerYtmLboaAlKbeWwWDG8Ju1PC408M9vbnV5cfkxFBc8w/TiNb5Czcad9tWC7QCfckRgyK3D5VJIwwwkdAMrLbmD+7pZkJ+IlCKLp06AxjtgCSmIUXDhgWbz/Oy+jOI7Gy6QIjlBWqOFK4KcpjhJVZuo+FWHdrD+0AHNWbRw88jjVmvfTbN1v3opVv65FWAqyC/rPLtxxZ+MIaPuY8pzQtERYFJRxZnT4Q3Ow1MLs0ORkDMn0qoDNjF0/d97iOPfQdTtmla+syUS7zqRIXvok09qx1l2LEXvLxAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAIBLeANadAJDBXwpnJw9/IKjlLC71koHvnAiDdUK7Y2ylmdoM2AIngFw5dhGtaD3xWeNd/wZCPy/oMReiaevtnTF/7Dji/VCViX9d1//SGwysHeNiy6gJ5VqlYApOGCQd+DLGBD72r8fIWntkmBtKh5uFCyTszLhrBk6vQZYNllOaj+Fn9In9FpJr4VhiZ8aM6osuDkn+I96D42PiTi4L9siJLuD9J8PQexquhkfT9gAuq1AYMGVORJIXTCRu5Qr/ACgEksc2ZxVgCqWXvUCc442C1L1ePKZfKaZu7vkB+3CDe/EJrLDQTAj+nXjgCAopD5wwMI27QDQjNjZeuksGrg=
c65ebfe2-c11d-403d-9f62-90104fd4c491	d4f4e15b-3f69-4340-ae31-3723e9fc44e7	algorithm	RSA-OAEP
20d1c023-b0ab-4f67-a544-a581b32ae456	9b45f15c-967f-43d8-bc43-bd5e8bc3ffd9	kid	7e0032e5-b543-446e-aad9-46064fe54e88
8cae23da-c741-4ddf-aad0-0d78ad71c1d7	9b45f15c-967f-43d8-bc43-bd5e8bc3ffd9	secret	3PBQ4aABp9YbMOE9AaaDiw
995b6e75-7195-4459-9717-0b5ae0ad28ed	9b45f15c-967f-43d8-bc43-bd5e8bc3ffd9	priority	100
13acb4ef-50ea-440d-9418-bb29d351ea06	df53b09d-05e1-4751-b118-060f316c97ba	keyUse	SIG
ac5cd388-bf7a-4cab-a0f5-f6bd0cd37f6a	df53b09d-05e1-4751-b118-060f316c97ba	privateKey	MIIEowIBAAKCAQEAy7L/wjJSfcgwOEtkvOb1L+Hfv2qITMELSpWFi2EuQFxRIEaTbIQC5PJT5vjCNAI1mItrSqPjpKU1SFUpEZSk3twGpWM/7qTKWvxm1yYJJyKBBV+iX65NALNMoFHW4RBRXyXy3lvMm24Q/xR/5dK96o6bjvOwm9+oYN8J8yVfEq2nUe8MAxnj1KBlKdETrXtfq/Qeu30mchBvgC7IhDyJwaodMkwG7ZT4jgD5AXqrt/tfUos1/RRGaGpiNktjTg5mQjzMYEIFRxg6NjGwr3/NYy41J7vKquglp4cBeUQYpvPgB9iDiVZHSG5QPqZoTfC3x6ymYVr+La7JEItf0bAKzwIDAQABAoIBAAli+j4sq3h4XSB6+O1rhyjps7HSau1+h9KsCTdfBw6YMnTWS7zYaHm8YPlnxSs4XtfktND/tGHF6yqmIfpZay+J3BSK+ks49Mo0j1iivBE9mcxxl73o/ktl98X7f3dnlRhZW1O7zzXqYIYgn7QrfeztHWX8/MpyCAROwtqdgkAOA2X5Xh0IGg08+VWl62E4J6GdNFdmbHyG7DnqtetTRPCkTMHMjOSGmTNBLdxBvPZ8S6jUtbZ/zImI/zu4zpId5z9u0meRBb7j0xWJs/7E5K6C9WpscK4JKt0iH7J1bhdA1Y1LCvtURJT6Ykq3xRT0yfrr0wdaTIqiFKO9Y537HgECgYEA99aS0D8qPTkRidsqsFR5qW3wAJAMwk4rqW+RRAZNpfeNAwQ3cuAe93vho3P7RdGlXje+ZVhiMHrmn8nNMq6bafIx0e37paBLaAC8rj810hf0Jh+OdcAteiy+Z/jwzynVRVRvGJm9ZCK+rljStE5BKaP4cyd+vGZatjbhyY+tl48CgYEA0mhOqcK7LBa5XJxcYhB8C4nlxkxvC2ReGRELZBuAVF6FwdfYVZJrr4lGO6lV7YKKt8T7uwJ9nG03EFmAXn0poVPvslxIosugPDkewUvu0UydEvvQKaUQCjmZDxw0C7g1l87ThjMi5cERr7TTYYri2GvGAXO6spxiCYp8i3X+uMECgYEAtTpnwvXdekVn6MmmDqjHCjkE/jRX0CH/VXfq3rZJQ2qg56rGrS7sFga1eaPPA0AJT7stc8hMjKziRcf4T+5UYQWknqEKmhN78IJRdo1sWsP/WX1L3Bj6aFOdrEPiO2qYtIjIcFHDpxytGKqE8SokBkIL5JDl4PhrrsC1HIH+60sCgYBcUKuCzA93LpkxSuE1nWnvXhdUQ6DM7MJkWRgYWgCaA8bH373o/Y8Fu0L3Vjp/NLFMI78Ws+cMxNZN9BbgXiXvxHX8WYT8+D5bbexSftBPQEACXj1cqDE7az3+ZS9onO/WpUYlMTZ0e5sY7kt4FomkztRXOsGFMBvLd9lhDuotgQKBgGvHjuZ2jCQkNJlOjQaOZxAD1MNX1gKJM6GjD2CVji/e+r9nBaPfRDETEd2qgW+Mi7cUQjoQfYtTaj98OguV2DJtAuzjjx6U2AfpuxKksFRf+7lY1fee/tRmy0CFBeJgdaNi+2DpvojwZJycM1tptK9t2PwLxvM/EIj3Beiv84eM
8e937de7-45ec-4f0a-89f2-f198cfa1e49d	df53b09d-05e1-4751-b118-060f316c97ba	priority	100
9862d325-54f1-4b15-a727-69496ae33310	df53b09d-05e1-4751-b118-060f316c97ba	certificate	MIICmzCCAYMCBgGYoso3wjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwODEzMDkzNTE4WhcNMzUwODEzMDkzNjU4WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDLsv/CMlJ9yDA4S2S85vUv4d+/aohMwQtKlYWLYS5AXFEgRpNshALk8lPm+MI0AjWYi2tKo+OkpTVIVSkRlKTe3AalYz/upMpa/GbXJgknIoEFX6Jfrk0As0ygUdbhEFFfJfLeW8ybbhD/FH/l0r3qjpuO87Cb36hg3wnzJV8SradR7wwDGePUoGUp0ROte1+r9B67fSZyEG+ALsiEPInBqh0yTAbtlPiOAPkBequ3+19SizX9FEZoamI2S2NODmZCPMxgQgVHGDo2MbCvf81jLjUnu8qq6CWnhwF5RBim8+AH2IOJVkdIblA+pmhN8LfHrKZhWv4trskQi1/RsArPAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAJZ5eW+twf2Tq5kfk4IekxrLBhJ0wUnWuKHqRx4H0yCs2ByZVPTt86kIrJywu7v3mdqbJwhO3sT4jYHN4qjUxyqEXUBxhJJK8Fw1sdbKl9Ls7jn4/5Ny6X9zagMiR09EL5GkAG4KJokT73XdgIVCcz7aG4bqrvc/+05c41QVy78qFA6z34QCkhOGqbo8b+1be4stnSDI5Pq+s9DfegwH5EavMHVk3jmacmLIwuVKGejyIawnvHmlDVysx3KfTo+lLpxsduLporxm1KtJLRgTALUnp1GdbWG28zaSRW01JuD9r+GJDES0Lp5b3yw5/I90x8rK4mZZzic0KPxF2UiBpic=
93647a4a-f81c-4c99-ac42-4f6b67b24c26	72c97651-135e-4e00-bca4-58a8c34a8049	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
d4a89002-21ca-494f-a964-b5817a9c710d	5d9f56ef-b260-4c93-8bc6-4cd55a9c345e	privateKey	MIIEpQIBAAKCAQEAtHFqh+P4yjnLV1IvdMpWe5NECiCusNPDvjh/dL+3onhOx2nuPeaDvnZp8hG1ggqq0FMQEGPZxN4epRQNyr/ww/s52GIvj2o/NDqA2qM1zO5j/WiW6WJ6yw/fufdFyNtWapuj9T5KdXK2XeFZFBq+d2Q4ca1I2JLx3g5HmBuO6vnI4Y39F+J6/nus+KX1gSZsBP9+f2XIQkE14KxUmlsgcz2qfCjdZaM90mHmDCU9cJGd3HZ5kYYf7HsQPWITy4oQVaFnNcWlbm1l9B2D5PkL4Z1tJ/1SVn0vIEo2RdwxBAgYsqCI8fjc92PRGsaL4foURUPltnjmz97N9bPmA53bIQIDAQABAoIBABed+5lHKZZAW8C1WVBCNnEMrJxdvDeZM/bG+smrWSvq7razgvL3o5kvcvzzu+vGHSbQpFrc0tEtWFn3Zrm5hxgDnwXXDg4JlDWwDZLwRzeoIQ63HH91/AftbzUuK+RW7vfboKlV6pV2Ou/NMaVLvc+vHqMkUNNF4mHTwSOjwcA30nZJN3x6MwzplqXaDUh5h3hW3vjsfS5dUZmVYp1DSftow7wIjrOnC6JZ/PfTID58LiqS7YCQ9vh20I0LBgPLOZ2KUBbsCFQYwtKXuk6Q8Gw/4EuX/sji64NIwCtTIClVtw6DglcwpHCcUkecXq7wIqYymFDaCmVrd49NM382mnUCgYEA4HDohmxUB5cPfFMk38asdlVXnFwIdhVusi9bFGynu34C3/I6irGGWPgjb3Gmdu5/nYmpKQ0t9+mURSnOPVDtINgtSj8xALCdyTtFrZjPVdDoTr4W3gjBz6iETAXbtyC/ocEsT7zeog3zoahYuoPUdI9Nk1TmPD7vORvaNmD3E8UCgYEAzdC7vAX5BnXPoXBOwVtWVZS5yc5SxnYyBp3aBdmla3VJJGRkgDmuxgar7IhkQaLovnTHAAavNkli15Xr+3ZBifkWUorSpzrIZk/oZXvAF14+ES+Y84zD450pHNO1jTDnvce08inrLwD2gw8OhcT/P52w8o8a7+GtXT4LxXv0c60CgYEA0r4SCA51xH66QrHLYPeq/p3Z2u6r3zz2qQdATWhNAwcqad+Hyq0wih/NHhqoBOqjF2ioVuySKkPAPkUn63kuf3Wc6Sd2usAcGFS4c22V2W2EhFOHI0szuOnx93RUv5pXdent0p10qtPQ3Q0260NX3W6ll97TJOSvOX+GoSLhPUUCgYEAmQsXHqieVaRzQcu+dF+T4k2Wna7TtIodhvgIMIN4U2DCg9I3PXYnNU+utlNxobEfOsihVa6iyU5mtoLgGHwGHi/f3n8mR34ZmKLg393WqEnHA4aOSMSqwW2TLcFr5lKwcFm5fr2XCbvAkxI2LVigqVB8TNIHKMt627QQksgqrX0CgYEAlcJWYMyPBEKCPJdrwip3gyUUoHlJRoyDgfLXS8Dz0RgxZSXKoxNEILyFsBYnZXDqYde4JXDdMqNQlow/CC86C7F9x/ZCn4Nx3+3VG96DjYmRgbuhchqVgovkSI19sRF/ST6JJF721mZ5vJ4z12nvlGkn1TbwKKCZmsa61pMqulk=
99fa244e-b117-44b9-8074-7cb4ec3402af	5d9f56ef-b260-4c93-8bc6-4cd55a9c345e	certificate	MIICpTCCAY0CBgGYov8lHjANBgkqhkiG9w0BAQsFADAWMRQwEgYDVQQDDAtleHRyYW5ldC1wcDAeFw0yNTA4MTMxMDMzMDZaFw0zNTA4MTMxMDM0NDZaMBYxFDASBgNVBAMMC2V4dHJhbmV0LXBwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtHFqh+P4yjnLV1IvdMpWe5NECiCusNPDvjh/dL+3onhOx2nuPeaDvnZp8hG1ggqq0FMQEGPZxN4epRQNyr/ww/s52GIvj2o/NDqA2qM1zO5j/WiW6WJ6yw/fufdFyNtWapuj9T5KdXK2XeFZFBq+d2Q4ca1I2JLx3g5HmBuO6vnI4Y39F+J6/nus+KX1gSZsBP9+f2XIQkE14KxUmlsgcz2qfCjdZaM90mHmDCU9cJGd3HZ5kYYf7HsQPWITy4oQVaFnNcWlbm1l9B2D5PkL4Z1tJ/1SVn0vIEo2RdwxBAgYsqCI8fjc92PRGsaL4foURUPltnjmz97N9bPmA53bIQIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQAmTfJA7mh91YKPVummnAdSr3exCX7rAldBqPyOnZl0IiNt0/vuhO0TlLz8QfHgZqV4JYC/MuuHLem3psXzvtKLFYLkSvJr4z5Tf8dfadLN/Y7RxY+Ws4Dm/XUQf3GLLBIFTpzVPCJgSPpbm/rJzWM/MjQifwOLE5EkonbmsvL84jOVyBnqQfVrBO/S1TnclZwowW9SfsfQkMKHcq66oDpPUvw94FQITfEIk9LGnoMoHCQhQ7i9Mbwbq6pZA3u9V+why09+zF+BxH1D1vEp1Y6I/0KjKDyD7pxtiNxYAEkpgh1WbcOOfQ74jNMC2dzVo8KL8uEmxEHogilKhzdCRJou
4daba0ff-ca2c-4efa-ade4-792a1b7a976a	5d9f56ef-b260-4c93-8bc6-4cd55a9c345e	priority	100
97b2851e-5ea2-47a1-9123-43ed2b089a80	5d9f56ef-b260-4c93-8bc6-4cd55a9c345e	keyUse	ENC
32c2c8e1-ab49-4802-9a3c-36aaea018e5a	5d9f56ef-b260-4c93-8bc6-4cd55a9c345e	algorithm	RSA-OAEP
ec4dba3c-5c04-4f2e-b0b9-0643b1c0d42c	caaac2a7-677c-4b3f-8cd0-864078a40b26	priority	100
5d7f60d0-39af-4af1-a57f-40c85268ee39	caaac2a7-677c-4b3f-8cd0-864078a40b26	algorithm	HS512
ddc387a5-0e1b-461f-9dae-3b76eaf6b8b3	caaac2a7-677c-4b3f-8cd0-864078a40b26	kid	15bda248-e2b9-41ff-a795-dc635fbf9ba9
5f492b66-0144-4b34-aeb9-35a60e8c360e	caaac2a7-677c-4b3f-8cd0-864078a40b26	secret	m_7FYrxh8Rdh-_33HwADcBR6rmS-fHS4W0-9LesxuQqvbWVWIOPcfsJ0l0GlFb81kSrVHCrnxe0_nwSI0TKNCgu4YVsdqzPOmNxE4vWa3n2XhV88BaCnHxsEB0KQWOfeGQtDaW8FYV60WpFSkOK7Zf_l_-uDPmHJ-QwXDXufFgc
29863a0c-56ba-46d2-9a0e-210c993f0d8d	1581aa6a-b7b4-4e2e-8331-cec1612e3ee5	privateKey	MIIEpAIBAAKCAQEApa+x5zNoCHDLVUSfpPGc8Rn3vicRevubvVd4kFv2R1WbFQO1IRm47dXnoZbCp7zTM3NuQV344dNvoHN54xLlDpqYOJfRpBvA10dE7vek51ch+Fozq8FrfA9tt6jadswUZHdnu78d9kzbVGzoYSeI6lsz1g9rnTlTd4npIeOLkJQbvbrzj/5QmwyHJa7S52VlWChmLdhk7kR/OgshP+BCQ+6gtY9e4fv7fXKuA9gt7IZcaMH97ZKheACKjotSFT4N8qKByyXfFee/1ci7a8vsTBqSw7XN5bV0+mFYrbZg9O4gEJMWQ0UzzhLoMpD7ob2YZOuogjYGWUrP7fpAyVrbRQIDAQABAoIBAAmPO8s8aM/13BF5ImHkq9qwVh4zSFupaTixM4xWtfyzKH27p0d34bbdPN5SobwGVcQ18IJWfu3eomXmS73JgQxI6Kf5QHgAvu1c2BIWmT3cxeG7qJgMEpzHkhvC4wnwJ+wNBJ/tPLgRgqUaHIVAf/KPnQvIe3vIizOOMjSJmauXfEEeRqnEJFeLMfVyCEIz6NCRLvZKSKg2VTmGnyl/CTWTRcfu6FrSQkR7xr0j8xJSnomQFsU/Ggj+h1h4vJpfVvEGHw76hQbl4B/U61Ud+J/iFXLAqbJsMWTh0W3k8HwDY3ywUYjwyUAqnljczgNIxKwpz/9xp8TSycyBgGYSATECgYEA12yr2JuqMzPVVaIwzoE0NUFz8XU/2RnDXcTL0QPPX0o0qBrWKld2Gg26vvHBJwcBpvoaw3gTGhKhalVr769JmJVhYfFCRtdl1FpMbERV6Q8BfkZuAUDoiyqUjTRD1cbOmda7SS8kOAI7MKQOXcgBIpkFiSpSYSKUhz/Aa5ftpLECgYEAxOS/+dP/NWh3MGMUjoe6MxYLgJ8fg8HAYtE/mvhd87UYI1g1vcrZfLZp8UbRQxl3lXs0GDrGYJzmdQDoM6jDpADrvvqig+wNb6yidyFHjWmQfBooETh3jYuKoOAK4ekGQR0IJHcJkAAM1CU0phIDAlFOwzvQ8fBh2cOVJyizFNUCgYEAnz+fXZXdYNJ9bzthtxZ+QKwtCJ7zXwsTiDrVrKKTZs7VVDvafByBmsrxdPwEHFSqnQQgSsV14X1KQ+/3xYyf7CLphVyy8OmERlGmUxbFJ29HXFC2O0j/XvlQLX4oc1zvF3xMoNIvhRPpK5DradpTNH9IP1jA4zuL7ttq5F7Ad1ECgYB7mzvmJC/ooI+K4fjKzeyYG7PW6I6JUb5siv7KVDfvQnZH4h3C67EDuSTjYtkGrdtEDZeTyno1tup687nSjJVdxXI6b/BMr4lz3UYVUeAwp+Ab+PPEc9WiF8NM4boTPw49HHO7KLvpGg7zs/PMeixHbTHsIQY4jPdxFXbyoXtjjQKBgQCNyFCfpTOGKiBMfgY5SuEs5EhP/KEwr76+Qkmj2/0p/dQCLQ+PWNUM7FDMdFSlIK9u7MFCwYuJ7IxiWpGVxHajBGdR7nAJQcJk0I0XtiT5klyzRWv4NgxjkxASIHsPNfLcZZ0EaQViiapGa88vUk0UUuGvg885Q/ppeeZKxskFEQ==
2fd8be55-10f1-4c11-8e74-caa9739ccce6	1581aa6a-b7b4-4e2e-8331-cec1612e3ee5	certificate	MIICpTCCAY0CBgGYov8kaDANBgkqhkiG9w0BAQsFADAWMRQwEgYDVQQDDAtleHRyYW5ldC1wcDAeFw0yNTA4MTMxMDMzMDZaFw0zNTA4MTMxMDM0NDZaMBYxFDASBgNVBAMMC2V4dHJhbmV0LXBwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApa+x5zNoCHDLVUSfpPGc8Rn3vicRevubvVd4kFv2R1WbFQO1IRm47dXnoZbCp7zTM3NuQV344dNvoHN54xLlDpqYOJfRpBvA10dE7vek51ch+Fozq8FrfA9tt6jadswUZHdnu78d9kzbVGzoYSeI6lsz1g9rnTlTd4npIeOLkJQbvbrzj/5QmwyHJa7S52VlWChmLdhk7kR/OgshP+BCQ+6gtY9e4fv7fXKuA9gt7IZcaMH97ZKheACKjotSFT4N8qKByyXfFee/1ci7a8vsTBqSw7XN5bV0+mFYrbZg9O4gEJMWQ0UzzhLoMpD7ob2YZOuogjYGWUrP7fpAyVrbRQIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQAQwtIIMmNfmABTo2sFBgIj6O4jbhRSVguiby811KCpZxP2Gj9MX1zEEllMRjo6qnq4aE0AgXCr8KWEsRfA1wIHxPZxfxl6O2iEyvvJfhY8+rdy5dyTk86r2ahOcC0cOebw925WtAbyYdtOq6uQCDXmLNn01HU7gES5MgAeB53OHaFOuRkSBDH8awAsx8o1hmlJXbF8i+3mrz9YIN4HrBI5Lb7wqsfPWhBh/T8MCkyI9p592bw/8Od8ejwIbMOifDx9POb8VGk3D4pm/H9v8nzorE+hCglupnu/eT+TEqCQarnqHRTF6nrBcB3g5MBEptrj8/RpHVRGBi7/AqAJU6Uq
bcf96887-0106-4990-b12e-03a79570db8b	1581aa6a-b7b4-4e2e-8331-cec1612e3ee5	keyUse	SIG
dacf8331-3908-4dd1-a75d-c34362de8693	1581aa6a-b7b4-4e2e-8331-cec1612e3ee5	priority	100
e48da10d-746d-46c8-bba3-2e0910ee84f1	9f924895-eec1-4a9e-b0d6-66a407da47cc	kid	1f9d809f-bbf9-488c-bbcf-6c63896c1bc9
c32b737b-6004-4dcf-b8bd-878344d37424	9f924895-eec1-4a9e-b0d6-66a407da47cc	secret	oac44eNnPUAVuhZkW2h34Q
4421a374-d06c-4e97-a48f-edbb24e481b6	9f924895-eec1-4a9e-b0d6-66a407da47cc	priority	100
1540fd6e-4605-41f6-9387-dc7f060efd0c	9fcb7f55-ce68-43c3-88f5-4714e5a89f7e	client-uris-must-match	true
6089e4cc-919c-4d3b-938d-a909daf0d827	9fcb7f55-ce68-43c3-88f5-4714e5a89f7e	host-sending-registration-request-must-match	true
25addacc-041d-45a4-ab71-a3b9789ce043	21100325-8473-4a91-9c36-4494db77854f	allow-default-scopes	true
9911e114-e818-481f-a924-b1d6a5a4cda1	c23195a8-8077-4a0e-8dee-b5dbd8818607	allow-default-scopes	true
868d43b4-eda3-4327-9351-a1db0a61e625	cf92a382-3fb9-426a-8b1f-fb9bc4515bdc	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
b6465ebf-2da6-47e2-8c76-d96434daec63	cf92a382-3fb9-426a-8b1f-fb9bc4515bdc	allowed-protocol-mapper-types	saml-role-list-mapper
24b8750b-7e53-44dd-b22e-4896f34e12e6	cf92a382-3fb9-426a-8b1f-fb9bc4515bdc	allowed-protocol-mapper-types	oidc-address-mapper
45ce3dcf-0da9-4c6b-817d-2b9738df79b6	cf92a382-3fb9-426a-8b1f-fb9bc4515bdc	allowed-protocol-mapper-types	oidc-full-name-mapper
6522950e-9099-4fd2-a694-28b4ee4457cb	cf92a382-3fb9-426a-8b1f-fb9bc4515bdc	allowed-protocol-mapper-types	saml-user-attribute-mapper
52b965c6-e278-4693-8353-b4673b22e7ac	cf92a382-3fb9-426a-8b1f-fb9bc4515bdc	allowed-protocol-mapper-types	saml-user-property-mapper
63328533-afa8-4e71-9b18-4bb320a74660	cf92a382-3fb9-426a-8b1f-fb9bc4515bdc	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
c6301cbf-495b-4b76-bbf1-b43a13484317	cf92a382-3fb9-426a-8b1f-fb9bc4515bdc	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
d65921aa-8536-4b29-b8c6-ac0e308c2870	782e26f2-9ec7-474a-9193-f88e646f3650	max-clients	200
9d480e57-28a1-444b-a21c-5d477c400090	78f83168-caab-4331-8424-eabc013e74cc	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
53a29a65-37e4-43f5-b518-6696aa0ecac6	78f83168-caab-4331-8424-eabc013e74cc	allowed-protocol-mapper-types	saml-role-list-mapper
9ccbe7e0-6e7c-42c0-9f5f-c338b831844e	78f83168-caab-4331-8424-eabc013e74cc	allowed-protocol-mapper-types	saml-user-attribute-mapper
6be5a30a-d1f5-455d-9f9c-6aa7af7a9c92	78f83168-caab-4331-8424-eabc013e74cc	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
3e181f6e-49ce-441f-953c-a9cfedbed556	78f83168-caab-4331-8424-eabc013e74cc	allowed-protocol-mapper-types	oidc-address-mapper
189110d0-012a-4859-9bd8-705f49d8ae4d	78f83168-caab-4331-8424-eabc013e74cc	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
489c709b-9659-4516-88f6-2b23c89b4d3c	78f83168-caab-4331-8424-eabc013e74cc	allowed-protocol-mapper-types	saml-user-property-mapper
c9ff88ae-d9d1-44ec-b30d-1fad35116d94	78f83168-caab-4331-8424-eabc013e74cc	allowed-protocol-mapper-types	oidc-full-name-mapper
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.composite_role (composite, child_role) FROM stdin;
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	794b6507-e84e-48a8-bc4c-13c94951886c
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	e9bbc45f-61ed-4643-859e-ac5d7c4ade25
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	d9085b54-ec85-44b7-898a-fd51110d9e63
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	e1f77940-d4e2-4daf-b4b1-f20d2e72cd51
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	7d1e0b07-bb35-4a8e-ac95-5cd8414fbfa0
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	dc6fe1c4-fef5-46aa-bc79-1de4a53a1ad8
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	182c9fb9-7983-4336-9bc9-f21e8a8a1a70
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	68854176-da94-44b7-8236-1be9915149db
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	cc29e223-45ca-4f5c-ae04-f2b1aa50ec6b
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	feefcdbe-a26c-49c6-837a-d6ad025c3347
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	78b9bab3-492f-434c-bb45-a7c5afbee349
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	17ad67bf-db23-4b06-8386-13a3cb7af9a7
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	616bd5e5-1f35-451b-871b-c68b8cc7da51
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	2da15747-30f4-494f-a20f-0d134cbb2a8e
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	8fcfe730-dd8d-4267-9b87-1208dcd2fe62
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	aa722032-e47f-4855-a55b-7262df2cc99a
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	c612a2f5-af33-4af9-9058-1ea4dcf1620a
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	5d31fe7c-3159-429b-b7a8-714f8d4b028e
7d1e0b07-bb35-4a8e-ac95-5cd8414fbfa0	aa722032-e47f-4855-a55b-7262df2cc99a
b093f3d7-7842-4d76-b4df-af8ec109efd7	16f7ab5c-f2ae-4c55-978b-4f1c4ba6fe61
e1f77940-d4e2-4daf-b4b1-f20d2e72cd51	8fcfe730-dd8d-4267-9b87-1208dcd2fe62
e1f77940-d4e2-4daf-b4b1-f20d2e72cd51	5d31fe7c-3159-429b-b7a8-714f8d4b028e
b093f3d7-7842-4d76-b4df-af8ec109efd7	0b92ba2c-1cb0-4095-89b9-7f5ef37f77d2
0b92ba2c-1cb0-4095-89b9-7f5ef37f77d2	37aa4ed2-6818-4f1d-925e-65d7ff53d941
30c4a601-154b-4311-a8b0-8d92c2da87ad	9b718154-0eca-432d-b54b-1af15b993dca
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	df0d5464-4eac-4953-a17f-50adab3f9d70
b093f3d7-7842-4d76-b4df-af8ec109efd7	51551348-4ef2-41ce-b4a7-2de5a84c200d
b093f3d7-7842-4d76-b4df-af8ec109efd7	6afbeb72-c2b3-4b3d-af8a-e10a562054c9
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	c3f55d54-a626-4e99-9c0b-0432b03fc6eb
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	5a139d44-ed81-444b-8f77-061084dbde67
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	3bf1afe6-247f-46bf-8cd0-b99b9fa01143
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	55d5c5cf-0361-4cd8-a6b4-17efc60848f6
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	e2a58d37-c7b1-4554-9417-f5013a7c5cfe
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	579d6bab-1e23-4475-9336-0477f6132de8
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	4bc44237-da64-4cab-835b-9ffc80e690cc
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	10896baf-f8c9-4a66-814e-1bf4ae53baac
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	65ebdb2b-2adb-4a32-84bb-f7b71e4cc339
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	3cfca402-67c4-4447-8369-29042c60a9da
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	c5c77c73-5e5f-4790-82b0-5018a2543b40
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	a7bb4544-ab9c-417f-ae6a-581130757ee3
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	8e8bde0f-6b92-4070-aef8-8c859ebcf646
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	81259698-5740-4136-9216-73eef737920e
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	3f792068-4e21-4da0-9505-db3f96921f83
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	67b60e26-d228-4454-85da-9cbb06717288
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	8741bc8d-8442-47a4-b9a6-c04ec6d91289
3bf1afe6-247f-46bf-8cd0-b99b9fa01143	8741bc8d-8442-47a4-b9a6-c04ec6d91289
3bf1afe6-247f-46bf-8cd0-b99b9fa01143	81259698-5740-4136-9216-73eef737920e
55d5c5cf-0361-4cd8-a6b4-17efc60848f6	3f792068-4e21-4da0-9505-db3f96921f83
7c0bae9c-a70d-4fac-8dbb-ee9be899e481	6ab9d722-870f-4f5c-a9bb-883000516ba6
7c0bae9c-a70d-4fac-8dbb-ee9be899e481	32734653-7dde-4260-b851-c53f816e1fb1
7c0bae9c-a70d-4fac-8dbb-ee9be899e481	784f017e-ace5-4911-b78f-8e6e99387fd0
7c0bae9c-a70d-4fac-8dbb-ee9be899e481	c7acdc8b-c0f9-4a9a-897f-8eb4d7d9b579
7c0bae9c-a70d-4fac-8dbb-ee9be899e481	b1d9e9ff-fe5a-4fed-a8c7-feef7d348e36
7c0bae9c-a70d-4fac-8dbb-ee9be899e481	362ab3c5-3a60-45d9-998e-f9eb1598eee6
7c0bae9c-a70d-4fac-8dbb-ee9be899e481	068fab5c-e329-48b8-a4c8-863829386748
7c0bae9c-a70d-4fac-8dbb-ee9be899e481	b5071d7f-db1c-4cb8-8f8c-d5c3c9bdcc37
7c0bae9c-a70d-4fac-8dbb-ee9be899e481	c8780b5f-9433-4377-b3df-4f16d96c10ce
7c0bae9c-a70d-4fac-8dbb-ee9be899e481	0fbf66a1-c4a5-43de-980d-10dfb1d8cdfd
7c0bae9c-a70d-4fac-8dbb-ee9be899e481	8540b911-2d5c-46a6-bc56-3d78987f95bd
7c0bae9c-a70d-4fac-8dbb-ee9be899e481	e889fde2-3bfc-4fd9-8651-89eab1df9580
7c0bae9c-a70d-4fac-8dbb-ee9be899e481	3d05fa7d-2ffb-46a2-bdaf-448898fc63c9
7c0bae9c-a70d-4fac-8dbb-ee9be899e481	899c36cb-d2e5-463f-be06-e97130e65028
7c0bae9c-a70d-4fac-8dbb-ee9be899e481	1ad2122f-b860-450d-b9f8-feb8cb6da271
7c0bae9c-a70d-4fac-8dbb-ee9be899e481	5472b346-8ff8-429d-9bd1-90b5ce47ed69
7c0bae9c-a70d-4fac-8dbb-ee9be899e481	3e782e0d-583b-4d26-a801-8bd1c54242d7
784f017e-ace5-4911-b78f-8e6e99387fd0	899c36cb-d2e5-463f-be06-e97130e65028
784f017e-ace5-4911-b78f-8e6e99387fd0	3e782e0d-583b-4d26-a801-8bd1c54242d7
c7acdc8b-c0f9-4a9a-897f-8eb4d7d9b579	1ad2122f-b860-450d-b9f8-feb8cb6da271
f781624a-0d6d-416e-b697-5fa0cf347a2b	a1eaf1b5-7806-42e1-9df7-5708054d8ac1
f781624a-0d6d-416e-b697-5fa0cf347a2b	db63010b-1fda-413c-8687-ea8592481f6d
db63010b-1fda-413c-8687-ea8592481f6d	e36d7da9-f221-42bd-997d-13bcf9952627
aadade80-b23a-4f06-9ddb-4ddf3dc41233	2da24d08-a639-4ab2-a3b9-f112a7189a9a
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	0cdc1548-dbcc-4470-bac0-af7edf1a87e7
7c0bae9c-a70d-4fac-8dbb-ee9be899e481	e25f480b-7585-45c7-8638-55b4454518d8
f781624a-0d6d-416e-b697-5fa0cf347a2b	a3bdece0-2d4f-4de5-bd75-15001b843e6f
f781624a-0d6d-416e-b697-5fa0cf347a2b	32d8958b-cdc0-4fde-846d-c6904fb7c16c
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
54713e0b-c7fd-4218-b042-e4534909374a	\N	password	615cde69-10db-466f-b499-38b6f064a958	1755077819273	\N	{"value":"lEt35Su7N8x+3CZlLwHnJKchlUGjjJ9mhuMTqcN6TDg=","salt":"4ubD7tnLAz92gtuU3HnNwg==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
7e46c7e8-6293-4569-ae92-8a6cb304cac3	\N	password	f8298003-4b6f-4c44-8c6c-9c133b6a3c9f	1755081286474	\N	{"value":"FLpEgZ4/xVKwwyQ1AKBNt1FsUaeI0rvbY8SIhBJ9ZoI=","salt":"5SICcClUt1LYGWL6F7FnVQ==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
22e4d73b-9be3-4444-9610-3ee63085b64e	\N	password	cd872f66-979d-42e9-8df7-a6ff27d1c717	1755096123337	\N	{"value":"lK7oaEOw2Hq3ToNTjqzlNQk198hzbjFDQmLt+3tieW8=","salt":"IdxJaVR+UsBL0ENT1Yxb0g==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
29fe30eb-f790-4427-8d7c-5ae91dfe07c0	\N	password	4b7b3cbb-d0b4-48e6-a4fb-ad8087ea623c	1755097407397	\N	{"value":"3rZumKNQbIFgvzuDnD6ajak+hOyf1EJVV+cH7REAenk=","salt":"ExOUDIj6POSfggS1yk4ZTQ==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2025-08-13 09:36:55.280211	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.25.1	\N	\N	5077814824
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2025-08-13 09:36:55.294078	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.25.1	\N	\N	5077814824
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2025-08-13 09:36:55.342453	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.25.1	\N	\N	5077814824
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2025-08-13 09:36:55.346867	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.25.1	\N	\N	5077814824
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2025-08-13 09:36:55.435062	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.25.1	\N	\N	5077814824
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2025-08-13 09:36:55.441161	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.25.1	\N	\N	5077814824
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2025-08-13 09:36:55.514766	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.25.1	\N	\N	5077814824
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2025-08-13 09:36:55.518988	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.25.1	\N	\N	5077814824
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2025-08-13 09:36:55.524518	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.25.1	\N	\N	5077814824
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2025-08-13 09:36:55.603856	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.25.1	\N	\N	5077814824
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2025-08-13 09:36:55.651636	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.25.1	\N	\N	5077814824
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2025-08-13 09:36:55.655705	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.25.1	\N	\N	5077814824
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2025-08-13 09:36:55.671841	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.25.1	\N	\N	5077814824
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-08-13 09:36:55.69071	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.25.1	\N	\N	5077814824
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-08-13 09:36:55.692535	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	5077814824
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-08-13 09:36:55.695142	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.25.1	\N	\N	5077814824
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-08-13 09:36:55.697865	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.25.1	\N	\N	5077814824
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2025-08-13 09:36:55.732445	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.25.1	\N	\N	5077814824
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2025-08-13 09:36:55.782314	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.25.1	\N	\N	5077814824
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2025-08-13 09:36:55.788291	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.25.1	\N	\N	5077814824
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2025-08-13 09:36:55.792181	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.25.1	\N	\N	5077814824
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2025-08-13 09:36:55.795508	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.25.1	\N	\N	5077814824
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2025-08-13 09:36:55.820567	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.25.1	\N	\N	5077814824
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2025-08-13 09:36:55.826524	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.25.1	\N	\N	5077814824
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2025-08-13 09:36:55.828351	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.25.1	\N	\N	5077814824
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2025-08-13 09:36:55.854819	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.25.1	\N	\N	5077814824
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2025-08-13 09:36:55.915559	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.25.1	\N	\N	5077814824
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2025-08-13 09:36:55.918779	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.25.1	\N	\N	5077814824
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2025-08-13 09:36:55.973941	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.25.1	\N	\N	5077814824
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2025-08-13 09:36:55.985694	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.25.1	\N	\N	5077814824
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2025-08-13 09:36:56.004941	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.25.1	\N	\N	5077814824
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2025-08-13 09:36:56.011945	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.25.1	\N	\N	5077814824
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-08-13 09:36:56.01918	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	5077814824
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-08-13 09:36:56.021176	34	MARK_RAN	9:3a32bace77c84d7678d035a7f5a8084e	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.25.1	\N	\N	5077814824
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-08-13 09:36:56.068186	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.25.1	\N	\N	5077814824
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2025-08-13 09:36:56.072607	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.25.1	\N	\N	5077814824
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-08-13 09:36:56.077367	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	5077814824
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2025-08-13 09:36:56.08022	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.25.1	\N	\N	5077814824
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2025-08-13 09:36:56.083024	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.25.1	\N	\N	5077814824
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-08-13 09:36:56.084179	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.25.1	\N	\N	5077814824
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-08-13 09:36:56.086768	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.25.1	\N	\N	5077814824
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2025-08-13 09:36:56.093664	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.25.1	\N	\N	5077814824
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-08-13 09:36:56.193689	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.25.1	\N	\N	5077814824
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2025-08-13 09:36:56.197615	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.25.1	\N	\N	5077814824
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-08-13 09:36:56.201162	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.25.1	\N	\N	5077814824
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-08-13 09:36:56.206678	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.25.1	\N	\N	5077814824
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-08-13 09:36:56.208534	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.25.1	\N	\N	5077814824
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-08-13 09:36:56.238701	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.25.1	\N	\N	5077814824
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-08-13 09:36:56.242761	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.25.1	\N	\N	5077814824
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2025-08-13 09:36:56.275901	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.25.1	\N	\N	5077814824
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2025-08-13 09:36:56.300105	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.25.1	\N	\N	5077814824
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2025-08-13 09:36:56.302888	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	5077814824
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2025-08-13 09:36:56.305232	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.25.1	\N	\N	5077814824
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2025-08-13 09:36:56.307351	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.25.1	\N	\N	5077814824
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-08-13 09:36:56.312528	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.25.1	\N	\N	5077814824
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-08-13 09:36:56.315694	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.25.1	\N	\N	5077814824
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-08-13 09:36:56.33167	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.25.1	\N	\N	5077814824
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-08-13 09:36:56.396641	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.25.1	\N	\N	5077814824
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2025-08-13 09:36:56.414432	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.25.1	\N	\N	5077814824
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2025-08-13 09:36:56.418909	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.25.1	\N	\N	5077814824
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-08-13 09:36:56.426601	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.25.1	\N	\N	5077814824
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-08-13 09:36:56.43124	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.25.1	\N	\N	5077814824
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2025-08-13 09:36:56.434859	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.25.1	\N	\N	5077814824
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2025-08-13 09:36:56.437824	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.25.1	\N	\N	5077814824
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2025-08-13 09:36:56.440613	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.25.1	\N	\N	5077814824
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2025-08-13 09:36:56.452725	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.25.1	\N	\N	5077814824
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2025-08-13 09:36:56.458028	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.25.1	\N	\N	5077814824
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2025-08-13 09:36:56.461957	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.25.1	\N	\N	5077814824
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2025-08-13 09:36:56.476206	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.25.1	\N	\N	5077814824
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2025-08-13 09:36:56.481502	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.25.1	\N	\N	5077814824
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2025-08-13 09:36:56.485725	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.25.1	\N	\N	5077814824
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-08-13 09:36:56.491573	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.25.1	\N	\N	5077814824
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-08-13 09:36:56.496936	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.25.1	\N	\N	5077814824
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-08-13 09:36:56.498547	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.25.1	\N	\N	5077814824
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-08-13 09:36:56.509925	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.25.1	\N	\N	5077814824
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-08-13 09:36:56.515519	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.25.1	\N	\N	5077814824
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-08-13 09:36:56.518773	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.25.1	\N	\N	5077814824
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-08-13 09:36:56.519985	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.25.1	\N	\N	5077814824
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-08-13 09:36:56.532886	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.25.1	\N	\N	5077814824
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-08-13 09:36:56.534295	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.25.1	\N	\N	5077814824
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-08-13 09:36:56.539331	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.25.1	\N	\N	5077814824
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-08-13 09:36:56.541235	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	5077814824
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-08-13 09:36:56.545799	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	5077814824
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-08-13 09:36:56.547372	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	5077814824
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-08-13 09:36:56.552899	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.25.1	\N	\N	5077814824
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2025-08-13 09:36:56.557595	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.25.1	\N	\N	5077814824
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-08-13 09:36:56.563371	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.25.1	\N	\N	5077814824
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-08-13 09:36:56.570635	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.25.1	\N	\N	5077814824
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-13 09:36:56.57734	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.25.1	\N	\N	5077814824
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-13 09:36:56.581947	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.25.1	\N	\N	5077814824
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-13 09:36:56.587791	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	5077814824
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-13 09:36:56.593073	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.25.1	\N	\N	5077814824
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-13 09:36:56.594312	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.25.1	\N	\N	5077814824
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-13 09:36:56.601043	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.25.1	\N	\N	5077814824
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-13 09:36:56.602638	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.25.1	\N	\N	5077814824
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-13 09:36:56.60774	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.25.1	\N	\N	5077814824
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-08-13 09:36:56.615559	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	5077814824
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-08-13 09:36:56.616854	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	5077814824
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-08-13 09:36:56.624889	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	5077814824
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-08-13 09:36:56.630676	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	5077814824
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-08-13 09:36:56.632475	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	5077814824
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-08-13 09:36:56.637727	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.25.1	\N	\N	5077814824
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-08-13 09:36:56.642993	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.25.1	\N	\N	5077814824
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2025-08-13 09:36:56.647495	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.25.1	\N	\N	5077814824
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2025-08-13 09:36:56.652601	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.25.1	\N	\N	5077814824
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2025-08-13 09:36:56.656822	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.25.1	\N	\N	5077814824
18.0.15-30992-index-consent	keycloak	META-INF/jpa-changelog-18.0.15.xml	2025-08-13 09:36:56.664015	107	EXECUTED	9:80071ede7a05604b1f4906f3bf3b00f0	createIndex indexName=IDX_USCONSENT_SCOPE_ID, tableName=USER_CONSENT_CLIENT_SCOPE		\N	4.25.1	\N	\N	5077814824
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2025-08-13 09:36:56.668701	108	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.25.1	\N	\N	5077814824
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-08-13 09:36:56.674006	109	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.25.1	\N	\N	5077814824
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-08-13 09:36:56.675337	110	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.25.1	\N	\N	5077814824
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-08-13 09:36:56.679838	111	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	5077814824
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2025-08-13 09:36:56.684632	112	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.25.1	\N	\N	5077814824
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-08-13 09:36:56.704975	113	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.25.1	\N	\N	5077814824
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-08-13 09:36:56.707326	114	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.25.1	\N	\N	5077814824
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-08-13 09:36:56.712697	115	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.25.1	\N	\N	5077814824
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-08-13 09:36:56.714211	116	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.25.1	\N	\N	5077814824
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-08-13 09:36:56.718716	117	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.25.1	\N	\N	5077814824
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-08-13 09:36:56.721285	118	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.25.1	\N	\N	5077814824
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-08-13 09:36:56.733649	119	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	4.25.1	\N	\N	5077814824
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-08-13 09:36:56.738036	120	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	4.25.1	\N	\N	5077814824
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-08-13 09:36:56.741706	121	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	5077814824
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-08-13 09:36:56.747497	122	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	5077814824
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-08-13 09:36:56.751466	123	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	4.25.1	\N	\N	5077814824
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-08-13 09:36:56.752632	124	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	5077814824
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-08-13 09:36:56.754205	125	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	5077814824
25.0.0-28265-tables	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-13 09:36:56.757853	126	EXECUTED	9:deda2df035df23388af95bbd36c17cef	addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION		\N	4.25.1	\N	\N	5077814824
25.0.0-28265-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-13 09:36:56.762755	127	EXECUTED	9:3e96709818458ae49f3c679ae58d263a	createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	5077814824
25.0.0-28265-index-cleanup	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-13 09:36:56.767449	128	EXECUTED	9:8c0cfa341a0474385b324f5c4b2dfcc1	dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION; dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION; dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION; dropIndex ...		\N	4.25.1	\N	\N	5077814824
25.0.0-28265-index-2-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-13 09:36:56.769307	129	MARK_RAN	9:b7ef76036d3126bb83c2423bf4d449d6	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	5077814824
25.0.0-28265-index-2-not-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-13 09:36:56.774691	130	EXECUTED	9:23396cf51ab8bc1ae6f0cac7f9f6fcf7	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	5077814824
25.0.0-org	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-13 09:36:56.789526	131	EXECUTED	9:5c859965c2c9b9c72136c360649af157	createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN		\N	4.25.1	\N	\N	5077814824
unique-consentuser	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-13 09:36:56.799617	132	EXECUTED	9:5857626a2ea8767e9a6c66bf3a2cb32f	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.25.1	\N	\N	5077814824
unique-consentuser-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-13 09:36:56.801048	133	MARK_RAN	9:b79478aad5adaa1bc428e31563f55e8e	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.25.1	\N	\N	5077814824
25.0.0-28861-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-13 09:36:56.807432	134	EXECUTED	9:b9acb58ac958d9ada0fe12a5d4794ab1	createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET		\N	4.25.1	\N	\N	5077814824
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
50f476a7-f350-43ba-8b98-a206554bea56	04fad609-0efa-40a2-be89-17d15e0cdc47	f
50f476a7-f350-43ba-8b98-a206554bea56	e5e54977-7eab-4990-87a0-566bbba00a28	t
50f476a7-f350-43ba-8b98-a206554bea56	56d80899-2a5f-461e-bb50-424fee17be16	t
50f476a7-f350-43ba-8b98-a206554bea56	7ef4a463-d594-4c2b-a6e0-2bbd1571e26d	t
50f476a7-f350-43ba-8b98-a206554bea56	96cd270b-7416-44a2-8415-58a5c024e377	f
50f476a7-f350-43ba-8b98-a206554bea56	e27253aa-3610-4e97-aac6-b5a88162aa91	f
50f476a7-f350-43ba-8b98-a206554bea56	c25c5113-088f-4c86-92d9-d5d01f0868f7	t
50f476a7-f350-43ba-8b98-a206554bea56	992ca06d-3a7b-4548-a6bd-ef237ffc5b77	t
50f476a7-f350-43ba-8b98-a206554bea56	b6a79f3a-5e6d-4950-9e3c-abf3a56d2d95	f
50f476a7-f350-43ba-8b98-a206554bea56	21b2b516-cb04-400c-86ff-30df256cbe3a	t
50f476a7-f350-43ba-8b98-a206554bea56	be4dbd84-12a7-4e80-a724-e978f538bc01	t
2fc07f5a-9f12-47ad-8999-54ec21d06664	404c21e9-aaf5-4982-bf23-ef149c7e200e	f
2fc07f5a-9f12-47ad-8999-54ec21d06664	28983cdd-e6e4-4396-9943-f8a37f34c461	t
2fc07f5a-9f12-47ad-8999-54ec21d06664	668bf349-0426-4c6f-becc-739acc709266	t
2fc07f5a-9f12-47ad-8999-54ec21d06664	edde022c-b83b-4ecd-9c2c-9e739d615cde	t
2fc07f5a-9f12-47ad-8999-54ec21d06664	b19faed9-8fd5-481a-92f7-80add32df9d9	f
2fc07f5a-9f12-47ad-8999-54ec21d06664	3bcb8921-7c43-4de0-afb1-bb3824cfd8b0	f
2fc07f5a-9f12-47ad-8999-54ec21d06664	4b3b68dd-ec00-41b3-9759-67badc56bb37	t
2fc07f5a-9f12-47ad-8999-54ec21d06664	bada85d6-c053-4101-8d0f-eda3c2568cbf	t
2fc07f5a-9f12-47ad-8999-54ec21d06664	df7770fb-fd2d-49db-a646-dd97f34e8b6f	f
2fc07f5a-9f12-47ad-8999-54ec21d06664	388e2005-f8e4-45ff-9980-7c7485577ac1	t
2fc07f5a-9f12-47ad-8999-54ec21d06664	4fa1b3b7-b92e-4909-ad74-dc55efe4737d	t
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
b1d9e9ff-fe5a-4fed-a8c7-feef7d348e36	d7377a63-8105-4783-99da-3f29ecaeb17c
32734653-7dde-4260-b851-c53f816e1fb1	d7377a63-8105-4783-99da-3f29ecaeb17c
2da24d08-a639-4ab2-a3b9-f112a7189a9a	d7377a63-8105-4783-99da-3f29ecaeb17c
362ab3c5-3a60-45d9-998e-f9eb1598eee6	d7377a63-8105-4783-99da-3f29ecaeb17c
784f017e-ace5-4911-b78f-8e6e99387fd0	d6da8b2a-625c-484d-9ea3-29107c1d9905
784f017e-ace5-4911-b78f-8e6e99387fd0	d7377a63-8105-4783-99da-3f29ecaeb17c
a1eaf1b5-7806-42e1-9df7-5708054d8ac1	d7377a63-8105-4783-99da-3f29ecaeb17c
c7acdc8b-c0f9-4a9a-897f-8eb4d7d9b579	d7377a63-8105-4783-99da-3f29ecaeb17c
6c76e76c-e39a-4a0e-8de9-31d550459f27	d7377a63-8105-4783-99da-3f29ecaeb17c
068fab5c-e329-48b8-a4c8-863829386748	d7377a63-8105-4783-99da-3f29ecaeb17c
1270a311-43e4-452c-b9b4-f5a6172274e4	d7377a63-8105-4783-99da-3f29ecaeb17c
32734653-7dde-4260-b851-c53f816e1fb1	d6da8b2a-625c-484d-9ea3-29107c1d9905
6c76e76c-e39a-4a0e-8de9-31d550459f27	d6da8b2a-625c-484d-9ea3-29107c1d9905
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
d7377a63-8105-4783-99da-3f29ecaeb17c	Adenis	 	2fc07f5a-9f12-47ad-8999-54ec21d06664
d6da8b2a-625c-484d-9ea3-29107c1d9905	Clients	 	2fc07f5a-9f12-47ad-8999-54ec21d06664
5d328112-bb96-418c-ae0f-d20a8b1be8ec	Carmsi Industry	d6da8b2a-625c-484d-9ea3-29107c1d9905	2fc07f5a-9f12-47ad-8999-54ec21d06664
92681d74-4b36-499f-a2a8-781472932ca8	First Industry	d6da8b2a-625c-484d-9ea3-29107c1d9905	2fc07f5a-9f12-47ad-8999-54ec21d06664
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
b093f3d7-7842-4d76-b4df-af8ec109efd7	50f476a7-f350-43ba-8b98-a206554bea56	f	${role_default-roles}	default-roles-master	50f476a7-f350-43ba-8b98-a206554bea56	\N	\N
794b6507-e84e-48a8-bc4c-13c94951886c	50f476a7-f350-43ba-8b98-a206554bea56	f	${role_create-realm}	create-realm	50f476a7-f350-43ba-8b98-a206554bea56	\N	\N
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	50f476a7-f350-43ba-8b98-a206554bea56	f	${role_admin}	admin	50f476a7-f350-43ba-8b98-a206554bea56	\N	\N
e9bbc45f-61ed-4643-859e-ac5d7c4ade25	0d818e3a-2fb1-49da-938d-757867de28a5	t	${role_create-client}	create-client	50f476a7-f350-43ba-8b98-a206554bea56	0d818e3a-2fb1-49da-938d-757867de28a5	\N
d9085b54-ec85-44b7-898a-fd51110d9e63	0d818e3a-2fb1-49da-938d-757867de28a5	t	${role_view-realm}	view-realm	50f476a7-f350-43ba-8b98-a206554bea56	0d818e3a-2fb1-49da-938d-757867de28a5	\N
e1f77940-d4e2-4daf-b4b1-f20d2e72cd51	0d818e3a-2fb1-49da-938d-757867de28a5	t	${role_view-users}	view-users	50f476a7-f350-43ba-8b98-a206554bea56	0d818e3a-2fb1-49da-938d-757867de28a5	\N
7d1e0b07-bb35-4a8e-ac95-5cd8414fbfa0	0d818e3a-2fb1-49da-938d-757867de28a5	t	${role_view-clients}	view-clients	50f476a7-f350-43ba-8b98-a206554bea56	0d818e3a-2fb1-49da-938d-757867de28a5	\N
dc6fe1c4-fef5-46aa-bc79-1de4a53a1ad8	0d818e3a-2fb1-49da-938d-757867de28a5	t	${role_view-events}	view-events	50f476a7-f350-43ba-8b98-a206554bea56	0d818e3a-2fb1-49da-938d-757867de28a5	\N
182c9fb9-7983-4336-9bc9-f21e8a8a1a70	0d818e3a-2fb1-49da-938d-757867de28a5	t	${role_view-identity-providers}	view-identity-providers	50f476a7-f350-43ba-8b98-a206554bea56	0d818e3a-2fb1-49da-938d-757867de28a5	\N
68854176-da94-44b7-8236-1be9915149db	0d818e3a-2fb1-49da-938d-757867de28a5	t	${role_view-authorization}	view-authorization	50f476a7-f350-43ba-8b98-a206554bea56	0d818e3a-2fb1-49da-938d-757867de28a5	\N
cc29e223-45ca-4f5c-ae04-f2b1aa50ec6b	0d818e3a-2fb1-49da-938d-757867de28a5	t	${role_manage-realm}	manage-realm	50f476a7-f350-43ba-8b98-a206554bea56	0d818e3a-2fb1-49da-938d-757867de28a5	\N
feefcdbe-a26c-49c6-837a-d6ad025c3347	0d818e3a-2fb1-49da-938d-757867de28a5	t	${role_manage-users}	manage-users	50f476a7-f350-43ba-8b98-a206554bea56	0d818e3a-2fb1-49da-938d-757867de28a5	\N
78b9bab3-492f-434c-bb45-a7c5afbee349	0d818e3a-2fb1-49da-938d-757867de28a5	t	${role_manage-clients}	manage-clients	50f476a7-f350-43ba-8b98-a206554bea56	0d818e3a-2fb1-49da-938d-757867de28a5	\N
17ad67bf-db23-4b06-8386-13a3cb7af9a7	0d818e3a-2fb1-49da-938d-757867de28a5	t	${role_manage-events}	manage-events	50f476a7-f350-43ba-8b98-a206554bea56	0d818e3a-2fb1-49da-938d-757867de28a5	\N
616bd5e5-1f35-451b-871b-c68b8cc7da51	0d818e3a-2fb1-49da-938d-757867de28a5	t	${role_manage-identity-providers}	manage-identity-providers	50f476a7-f350-43ba-8b98-a206554bea56	0d818e3a-2fb1-49da-938d-757867de28a5	\N
2da15747-30f4-494f-a20f-0d134cbb2a8e	0d818e3a-2fb1-49da-938d-757867de28a5	t	${role_manage-authorization}	manage-authorization	50f476a7-f350-43ba-8b98-a206554bea56	0d818e3a-2fb1-49da-938d-757867de28a5	\N
8fcfe730-dd8d-4267-9b87-1208dcd2fe62	0d818e3a-2fb1-49da-938d-757867de28a5	t	${role_query-users}	query-users	50f476a7-f350-43ba-8b98-a206554bea56	0d818e3a-2fb1-49da-938d-757867de28a5	\N
aa722032-e47f-4855-a55b-7262df2cc99a	0d818e3a-2fb1-49da-938d-757867de28a5	t	${role_query-clients}	query-clients	50f476a7-f350-43ba-8b98-a206554bea56	0d818e3a-2fb1-49da-938d-757867de28a5	\N
c612a2f5-af33-4af9-9058-1ea4dcf1620a	0d818e3a-2fb1-49da-938d-757867de28a5	t	${role_query-realms}	query-realms	50f476a7-f350-43ba-8b98-a206554bea56	0d818e3a-2fb1-49da-938d-757867de28a5	\N
5d31fe7c-3159-429b-b7a8-714f8d4b028e	0d818e3a-2fb1-49da-938d-757867de28a5	t	${role_query-groups}	query-groups	50f476a7-f350-43ba-8b98-a206554bea56	0d818e3a-2fb1-49da-938d-757867de28a5	\N
16f7ab5c-f2ae-4c55-978b-4f1c4ba6fe61	bfcbc2d9-28f2-41b3-ab8f-e3ec970dd844	t	${role_view-profile}	view-profile	50f476a7-f350-43ba-8b98-a206554bea56	bfcbc2d9-28f2-41b3-ab8f-e3ec970dd844	\N
0b92ba2c-1cb0-4095-89b9-7f5ef37f77d2	bfcbc2d9-28f2-41b3-ab8f-e3ec970dd844	t	${role_manage-account}	manage-account	50f476a7-f350-43ba-8b98-a206554bea56	bfcbc2d9-28f2-41b3-ab8f-e3ec970dd844	\N
37aa4ed2-6818-4f1d-925e-65d7ff53d941	bfcbc2d9-28f2-41b3-ab8f-e3ec970dd844	t	${role_manage-account-links}	manage-account-links	50f476a7-f350-43ba-8b98-a206554bea56	bfcbc2d9-28f2-41b3-ab8f-e3ec970dd844	\N
07f9adfa-3a61-48ae-aeef-90c27bf8dde8	bfcbc2d9-28f2-41b3-ab8f-e3ec970dd844	t	${role_view-applications}	view-applications	50f476a7-f350-43ba-8b98-a206554bea56	bfcbc2d9-28f2-41b3-ab8f-e3ec970dd844	\N
9b718154-0eca-432d-b54b-1af15b993dca	bfcbc2d9-28f2-41b3-ab8f-e3ec970dd844	t	${role_view-consent}	view-consent	50f476a7-f350-43ba-8b98-a206554bea56	bfcbc2d9-28f2-41b3-ab8f-e3ec970dd844	\N
30c4a601-154b-4311-a8b0-8d92c2da87ad	bfcbc2d9-28f2-41b3-ab8f-e3ec970dd844	t	${role_manage-consent}	manage-consent	50f476a7-f350-43ba-8b98-a206554bea56	bfcbc2d9-28f2-41b3-ab8f-e3ec970dd844	\N
575ba2c8-c8fd-4da8-8e2e-7547402d7fe0	bfcbc2d9-28f2-41b3-ab8f-e3ec970dd844	t	${role_view-groups}	view-groups	50f476a7-f350-43ba-8b98-a206554bea56	bfcbc2d9-28f2-41b3-ab8f-e3ec970dd844	\N
bf4c3fc6-07eb-4ee0-bac4-1361cdaa7d4e	bfcbc2d9-28f2-41b3-ab8f-e3ec970dd844	t	${role_delete-account}	delete-account	50f476a7-f350-43ba-8b98-a206554bea56	bfcbc2d9-28f2-41b3-ab8f-e3ec970dd844	\N
1d1dd5d4-3646-440f-91a1-f8b79f8f1760	807aea33-e235-4992-9b80-98f9cf3cef24	t	${role_read-token}	read-token	50f476a7-f350-43ba-8b98-a206554bea56	807aea33-e235-4992-9b80-98f9cf3cef24	\N
df0d5464-4eac-4953-a17f-50adab3f9d70	0d818e3a-2fb1-49da-938d-757867de28a5	t	${role_impersonation}	impersonation	50f476a7-f350-43ba-8b98-a206554bea56	0d818e3a-2fb1-49da-938d-757867de28a5	\N
51551348-4ef2-41ce-b4a7-2de5a84c200d	50f476a7-f350-43ba-8b98-a206554bea56	f	${role_offline-access}	offline_access	50f476a7-f350-43ba-8b98-a206554bea56	\N	\N
6afbeb72-c2b3-4b3d-af8a-e10a562054c9	50f476a7-f350-43ba-8b98-a206554bea56	f	${role_uma_authorization}	uma_authorization	50f476a7-f350-43ba-8b98-a206554bea56	\N	\N
f781624a-0d6d-416e-b697-5fa0cf347a2b	2fc07f5a-9f12-47ad-8999-54ec21d06664	f	${role_default-roles}	default-roles-extranet-pp	2fc07f5a-9f12-47ad-8999-54ec21d06664	\N	\N
c3f55d54-a626-4e99-9c0b-0432b03fc6eb	6e404e1f-3d41-475f-9a88-8c14f663b4a2	t	${role_create-client}	create-client	50f476a7-f350-43ba-8b98-a206554bea56	6e404e1f-3d41-475f-9a88-8c14f663b4a2	\N
5a139d44-ed81-444b-8f77-061084dbde67	6e404e1f-3d41-475f-9a88-8c14f663b4a2	t	${role_view-realm}	view-realm	50f476a7-f350-43ba-8b98-a206554bea56	6e404e1f-3d41-475f-9a88-8c14f663b4a2	\N
3bf1afe6-247f-46bf-8cd0-b99b9fa01143	6e404e1f-3d41-475f-9a88-8c14f663b4a2	t	${role_view-users}	view-users	50f476a7-f350-43ba-8b98-a206554bea56	6e404e1f-3d41-475f-9a88-8c14f663b4a2	\N
55d5c5cf-0361-4cd8-a6b4-17efc60848f6	6e404e1f-3d41-475f-9a88-8c14f663b4a2	t	${role_view-clients}	view-clients	50f476a7-f350-43ba-8b98-a206554bea56	6e404e1f-3d41-475f-9a88-8c14f663b4a2	\N
e2a58d37-c7b1-4554-9417-f5013a7c5cfe	6e404e1f-3d41-475f-9a88-8c14f663b4a2	t	${role_view-events}	view-events	50f476a7-f350-43ba-8b98-a206554bea56	6e404e1f-3d41-475f-9a88-8c14f663b4a2	\N
579d6bab-1e23-4475-9336-0477f6132de8	6e404e1f-3d41-475f-9a88-8c14f663b4a2	t	${role_view-identity-providers}	view-identity-providers	50f476a7-f350-43ba-8b98-a206554bea56	6e404e1f-3d41-475f-9a88-8c14f663b4a2	\N
4bc44237-da64-4cab-835b-9ffc80e690cc	6e404e1f-3d41-475f-9a88-8c14f663b4a2	t	${role_view-authorization}	view-authorization	50f476a7-f350-43ba-8b98-a206554bea56	6e404e1f-3d41-475f-9a88-8c14f663b4a2	\N
10896baf-f8c9-4a66-814e-1bf4ae53baac	6e404e1f-3d41-475f-9a88-8c14f663b4a2	t	${role_manage-realm}	manage-realm	50f476a7-f350-43ba-8b98-a206554bea56	6e404e1f-3d41-475f-9a88-8c14f663b4a2	\N
65ebdb2b-2adb-4a32-84bb-f7b71e4cc339	6e404e1f-3d41-475f-9a88-8c14f663b4a2	t	${role_manage-users}	manage-users	50f476a7-f350-43ba-8b98-a206554bea56	6e404e1f-3d41-475f-9a88-8c14f663b4a2	\N
3cfca402-67c4-4447-8369-29042c60a9da	6e404e1f-3d41-475f-9a88-8c14f663b4a2	t	${role_manage-clients}	manage-clients	50f476a7-f350-43ba-8b98-a206554bea56	6e404e1f-3d41-475f-9a88-8c14f663b4a2	\N
c5c77c73-5e5f-4790-82b0-5018a2543b40	6e404e1f-3d41-475f-9a88-8c14f663b4a2	t	${role_manage-events}	manage-events	50f476a7-f350-43ba-8b98-a206554bea56	6e404e1f-3d41-475f-9a88-8c14f663b4a2	\N
a7bb4544-ab9c-417f-ae6a-581130757ee3	6e404e1f-3d41-475f-9a88-8c14f663b4a2	t	${role_manage-identity-providers}	manage-identity-providers	50f476a7-f350-43ba-8b98-a206554bea56	6e404e1f-3d41-475f-9a88-8c14f663b4a2	\N
8e8bde0f-6b92-4070-aef8-8c859ebcf646	6e404e1f-3d41-475f-9a88-8c14f663b4a2	t	${role_manage-authorization}	manage-authorization	50f476a7-f350-43ba-8b98-a206554bea56	6e404e1f-3d41-475f-9a88-8c14f663b4a2	\N
81259698-5740-4136-9216-73eef737920e	6e404e1f-3d41-475f-9a88-8c14f663b4a2	t	${role_query-users}	query-users	50f476a7-f350-43ba-8b98-a206554bea56	6e404e1f-3d41-475f-9a88-8c14f663b4a2	\N
3f792068-4e21-4da0-9505-db3f96921f83	6e404e1f-3d41-475f-9a88-8c14f663b4a2	t	${role_query-clients}	query-clients	50f476a7-f350-43ba-8b98-a206554bea56	6e404e1f-3d41-475f-9a88-8c14f663b4a2	\N
67b60e26-d228-4454-85da-9cbb06717288	6e404e1f-3d41-475f-9a88-8c14f663b4a2	t	${role_query-realms}	query-realms	50f476a7-f350-43ba-8b98-a206554bea56	6e404e1f-3d41-475f-9a88-8c14f663b4a2	\N
8741bc8d-8442-47a4-b9a6-c04ec6d91289	6e404e1f-3d41-475f-9a88-8c14f663b4a2	t	${role_query-groups}	query-groups	50f476a7-f350-43ba-8b98-a206554bea56	6e404e1f-3d41-475f-9a88-8c14f663b4a2	\N
7c0bae9c-a70d-4fac-8dbb-ee9be899e481	47f0efe6-666f-428e-985a-c4b2770df830	t	${role_realm-admin}	realm-admin	2fc07f5a-9f12-47ad-8999-54ec21d06664	47f0efe6-666f-428e-985a-c4b2770df830	\N
6ab9d722-870f-4f5c-a9bb-883000516ba6	47f0efe6-666f-428e-985a-c4b2770df830	t	${role_create-client}	create-client	2fc07f5a-9f12-47ad-8999-54ec21d06664	47f0efe6-666f-428e-985a-c4b2770df830	\N
32734653-7dde-4260-b851-c53f816e1fb1	47f0efe6-666f-428e-985a-c4b2770df830	t	${role_view-realm}	view-realm	2fc07f5a-9f12-47ad-8999-54ec21d06664	47f0efe6-666f-428e-985a-c4b2770df830	\N
784f017e-ace5-4911-b78f-8e6e99387fd0	47f0efe6-666f-428e-985a-c4b2770df830	t	${role_view-users}	view-users	2fc07f5a-9f12-47ad-8999-54ec21d06664	47f0efe6-666f-428e-985a-c4b2770df830	\N
c7acdc8b-c0f9-4a9a-897f-8eb4d7d9b579	47f0efe6-666f-428e-985a-c4b2770df830	t	${role_view-clients}	view-clients	2fc07f5a-9f12-47ad-8999-54ec21d06664	47f0efe6-666f-428e-985a-c4b2770df830	\N
b1d9e9ff-fe5a-4fed-a8c7-feef7d348e36	47f0efe6-666f-428e-985a-c4b2770df830	t	${role_view-events}	view-events	2fc07f5a-9f12-47ad-8999-54ec21d06664	47f0efe6-666f-428e-985a-c4b2770df830	\N
362ab3c5-3a60-45d9-998e-f9eb1598eee6	47f0efe6-666f-428e-985a-c4b2770df830	t	${role_view-identity-providers}	view-identity-providers	2fc07f5a-9f12-47ad-8999-54ec21d06664	47f0efe6-666f-428e-985a-c4b2770df830	\N
068fab5c-e329-48b8-a4c8-863829386748	47f0efe6-666f-428e-985a-c4b2770df830	t	${role_view-authorization}	view-authorization	2fc07f5a-9f12-47ad-8999-54ec21d06664	47f0efe6-666f-428e-985a-c4b2770df830	\N
b5071d7f-db1c-4cb8-8f8c-d5c3c9bdcc37	47f0efe6-666f-428e-985a-c4b2770df830	t	${role_manage-realm}	manage-realm	2fc07f5a-9f12-47ad-8999-54ec21d06664	47f0efe6-666f-428e-985a-c4b2770df830	\N
c8780b5f-9433-4377-b3df-4f16d96c10ce	47f0efe6-666f-428e-985a-c4b2770df830	t	${role_manage-users}	manage-users	2fc07f5a-9f12-47ad-8999-54ec21d06664	47f0efe6-666f-428e-985a-c4b2770df830	\N
0fbf66a1-c4a5-43de-980d-10dfb1d8cdfd	47f0efe6-666f-428e-985a-c4b2770df830	t	${role_manage-clients}	manage-clients	2fc07f5a-9f12-47ad-8999-54ec21d06664	47f0efe6-666f-428e-985a-c4b2770df830	\N
8540b911-2d5c-46a6-bc56-3d78987f95bd	47f0efe6-666f-428e-985a-c4b2770df830	t	${role_manage-events}	manage-events	2fc07f5a-9f12-47ad-8999-54ec21d06664	47f0efe6-666f-428e-985a-c4b2770df830	\N
32d8958b-cdc0-4fde-846d-c6904fb7c16c	2fc07f5a-9f12-47ad-8999-54ec21d06664	f	${role_uma_authorization}	uma_authorization	2fc07f5a-9f12-47ad-8999-54ec21d06664	\N	\N
e889fde2-3bfc-4fd9-8651-89eab1df9580	47f0efe6-666f-428e-985a-c4b2770df830	t	${role_manage-identity-providers}	manage-identity-providers	2fc07f5a-9f12-47ad-8999-54ec21d06664	47f0efe6-666f-428e-985a-c4b2770df830	\N
3d05fa7d-2ffb-46a2-bdaf-448898fc63c9	47f0efe6-666f-428e-985a-c4b2770df830	t	${role_manage-authorization}	manage-authorization	2fc07f5a-9f12-47ad-8999-54ec21d06664	47f0efe6-666f-428e-985a-c4b2770df830	\N
899c36cb-d2e5-463f-be06-e97130e65028	47f0efe6-666f-428e-985a-c4b2770df830	t	${role_query-users}	query-users	2fc07f5a-9f12-47ad-8999-54ec21d06664	47f0efe6-666f-428e-985a-c4b2770df830	\N
1ad2122f-b860-450d-b9f8-feb8cb6da271	47f0efe6-666f-428e-985a-c4b2770df830	t	${role_query-clients}	query-clients	2fc07f5a-9f12-47ad-8999-54ec21d06664	47f0efe6-666f-428e-985a-c4b2770df830	\N
5472b346-8ff8-429d-9bd1-90b5ce47ed69	47f0efe6-666f-428e-985a-c4b2770df830	t	${role_query-realms}	query-realms	2fc07f5a-9f12-47ad-8999-54ec21d06664	47f0efe6-666f-428e-985a-c4b2770df830	\N
3e782e0d-583b-4d26-a801-8bd1c54242d7	47f0efe6-666f-428e-985a-c4b2770df830	t	${role_query-groups}	query-groups	2fc07f5a-9f12-47ad-8999-54ec21d06664	47f0efe6-666f-428e-985a-c4b2770df830	\N
a1eaf1b5-7806-42e1-9df7-5708054d8ac1	120af667-e73e-4e08-a4e0-4d0207158d7c	t	${role_view-profile}	view-profile	2fc07f5a-9f12-47ad-8999-54ec21d06664	120af667-e73e-4e08-a4e0-4d0207158d7c	\N
db63010b-1fda-413c-8687-ea8592481f6d	120af667-e73e-4e08-a4e0-4d0207158d7c	t	${role_manage-account}	manage-account	2fc07f5a-9f12-47ad-8999-54ec21d06664	120af667-e73e-4e08-a4e0-4d0207158d7c	\N
e36d7da9-f221-42bd-997d-13bcf9952627	120af667-e73e-4e08-a4e0-4d0207158d7c	t	${role_manage-account-links}	manage-account-links	2fc07f5a-9f12-47ad-8999-54ec21d06664	120af667-e73e-4e08-a4e0-4d0207158d7c	\N
1270a311-43e4-452c-b9b4-f5a6172274e4	120af667-e73e-4e08-a4e0-4d0207158d7c	t	${role_view-applications}	view-applications	2fc07f5a-9f12-47ad-8999-54ec21d06664	120af667-e73e-4e08-a4e0-4d0207158d7c	\N
2da24d08-a639-4ab2-a3b9-f112a7189a9a	120af667-e73e-4e08-a4e0-4d0207158d7c	t	${role_view-consent}	view-consent	2fc07f5a-9f12-47ad-8999-54ec21d06664	120af667-e73e-4e08-a4e0-4d0207158d7c	\N
aadade80-b23a-4f06-9ddb-4ddf3dc41233	120af667-e73e-4e08-a4e0-4d0207158d7c	t	${role_manage-consent}	manage-consent	2fc07f5a-9f12-47ad-8999-54ec21d06664	120af667-e73e-4e08-a4e0-4d0207158d7c	\N
6c76e76c-e39a-4a0e-8de9-31d550459f27	120af667-e73e-4e08-a4e0-4d0207158d7c	t	${role_view-groups}	view-groups	2fc07f5a-9f12-47ad-8999-54ec21d06664	120af667-e73e-4e08-a4e0-4d0207158d7c	\N
3dd1ca0c-a8dd-4305-bf93-1cb5072ed000	120af667-e73e-4e08-a4e0-4d0207158d7c	t	${role_delete-account}	delete-account	2fc07f5a-9f12-47ad-8999-54ec21d06664	120af667-e73e-4e08-a4e0-4d0207158d7c	\N
0cdc1548-dbcc-4470-bac0-af7edf1a87e7	6e404e1f-3d41-475f-9a88-8c14f663b4a2	t	${role_impersonation}	impersonation	50f476a7-f350-43ba-8b98-a206554bea56	6e404e1f-3d41-475f-9a88-8c14f663b4a2	\N
e25f480b-7585-45c7-8638-55b4454518d8	47f0efe6-666f-428e-985a-c4b2770df830	t	${role_impersonation}	impersonation	2fc07f5a-9f12-47ad-8999-54ec21d06664	47f0efe6-666f-428e-985a-c4b2770df830	\N
58176dd8-8a8f-4a79-9f90-995c49479fd8	4884a5cc-31e3-4050-a98a-bc96805cfc3a	t	${role_read-token}	read-token	2fc07f5a-9f12-47ad-8999-54ec21d06664	4884a5cc-31e3-4050-a98a-bc96805cfc3a	\N
a3bdece0-2d4f-4de5-bd75-15001b843e6f	2fc07f5a-9f12-47ad-8999-54ec21d06664	f	${role_offline-access}	offline_access	2fc07f5a-9f12-47ad-8999-54ec21d06664	\N	\N
10eb566d-5b54-4db5-869c-46efa488e06c	2fc07f5a-9f12-47ad-8999-54ec21d06664	f	\N	user	2fc07f5a-9f12-47ad-8999-54ec21d06664	\N	\N
c73e7344-f522-4b7b-bdad-63246570c1b0	11ada4c6-3523-4a02-a7cf-2c3f06c7e176	t	\N	user	2fc07f5a-9f12-47ad-8999-54ec21d06664	11ada4c6-3523-4a02-a7cf-2c3f06c7e176	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.migration_model (id, version, update_time) FROM stdin;
bhj07	25.0.6	1755077817
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id, version) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh, broker_session_id, version) FROM stdin;
\.


--
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.org (id, enabled, realm_id, group_id, name, description) FROM stdin;
\.


--
-- Data for Name: org_domain; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.org_domain (id, name, verified, org_id) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
8f90e140-f4bd-4064-834c-6c9de8cac966	audience resolve	openid-connect	oidc-audience-resolve-mapper	dda90977-935d-46a5-9869-cf36a2ef0e96	\N
75bebd6e-4879-45f4-bf65-8f2a68f9e102	locale	openid-connect	oidc-usermodel-attribute-mapper	88de62f1-8110-4f86-95b6-fb4df82ef163	\N
03dc90a1-f8e0-43ac-8964-4e3bcd431e35	role list	saml	saml-role-list-mapper	\N	e5e54977-7eab-4990-87a0-566bbba00a28
65386236-4bf5-47e3-844c-2bb74ff0ae7d	full name	openid-connect	oidc-full-name-mapper	\N	56d80899-2a5f-461e-bb50-424fee17be16
19be34f5-cc24-4a57-9f5f-23b8f9e07d07	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	56d80899-2a5f-461e-bb50-424fee17be16
ef1e6add-8b4b-4fca-8b0c-9ab06c26a1b8	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	56d80899-2a5f-461e-bb50-424fee17be16
405b0cd9-175c-4b6d-84d3-eae32f4dc5c9	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	56d80899-2a5f-461e-bb50-424fee17be16
6653f451-0dbb-4e52-b874-a2f959f35764	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	56d80899-2a5f-461e-bb50-424fee17be16
c5080530-dd0e-4571-b710-b0449e906f6c	username	openid-connect	oidc-usermodel-attribute-mapper	\N	56d80899-2a5f-461e-bb50-424fee17be16
72360a10-7658-425e-9440-515868812955	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	56d80899-2a5f-461e-bb50-424fee17be16
0d318434-808a-4a28-89be-03663e1a250b	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	56d80899-2a5f-461e-bb50-424fee17be16
c09be8e4-830c-4537-b12f-64f698cc5a04	website	openid-connect	oidc-usermodel-attribute-mapper	\N	56d80899-2a5f-461e-bb50-424fee17be16
847c8447-87f3-4d69-8a17-de196f30255e	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	56d80899-2a5f-461e-bb50-424fee17be16
2a8f0c47-d241-443b-907f-5f95849cfb5a	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	56d80899-2a5f-461e-bb50-424fee17be16
a4550e86-f242-487e-a29a-fc192e81ba20	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	56d80899-2a5f-461e-bb50-424fee17be16
3b5e73d2-ef7b-49dd-9beb-76f0f7d95a49	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	56d80899-2a5f-461e-bb50-424fee17be16
9fc6d9ae-25c6-4fc5-8051-64fbb832a654	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	56d80899-2a5f-461e-bb50-424fee17be16
a6388573-8c9d-4b2c-8fe4-dffdbda5f6db	email	openid-connect	oidc-usermodel-attribute-mapper	\N	7ef4a463-d594-4c2b-a6e0-2bbd1571e26d
81586885-28ca-465f-aec3-21fdfebc71e3	email verified	openid-connect	oidc-usermodel-property-mapper	\N	7ef4a463-d594-4c2b-a6e0-2bbd1571e26d
aa5e155b-0a68-4262-9d1d-c454bb780fe7	address	openid-connect	oidc-address-mapper	\N	96cd270b-7416-44a2-8415-58a5c024e377
da1f394e-2bb8-466b-b753-c5878b15479d	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	e27253aa-3610-4e97-aac6-b5a88162aa91
323ce640-ce0e-4f00-859b-dc39feed27c9	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	e27253aa-3610-4e97-aac6-b5a88162aa91
d531f0bb-6cf3-478d-ad0a-96790cb7fef4	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	c25c5113-088f-4c86-92d9-d5d01f0868f7
9569422a-d430-4665-aada-eefc5481aaff	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	c25c5113-088f-4c86-92d9-d5d01f0868f7
51ddd7ca-0b6e-4145-879e-7731c216fa8d	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	c25c5113-088f-4c86-92d9-d5d01f0868f7
b17fb4b1-1897-4640-ad07-a46d47474769	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	992ca06d-3a7b-4548-a6bd-ef237ffc5b77
d5d96703-cfbc-4c22-abb3-41f6010f6882	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	b6a79f3a-5e6d-4950-9e3c-abf3a56d2d95
d1a9b576-38de-44c3-912c-728a7be52b12	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	b6a79f3a-5e6d-4950-9e3c-abf3a56d2d95
18d037b3-8254-4034-999c-19bf23572564	acr loa level	openid-connect	oidc-acr-mapper	\N	21b2b516-cb04-400c-86ff-30df256cbe3a
26a4b2a0-15fd-4d1a-9961-f71bafb994aa	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	be4dbd84-12a7-4e80-a724-e978f538bc01
ac858d80-dcab-4078-b700-a2d1ab4e6bb0	sub	openid-connect	oidc-sub-mapper	\N	be4dbd84-12a7-4e80-a724-e978f538bc01
c0d159fa-67ea-437b-a29b-76d7f8f34d3d	audience resolve	openid-connect	oidc-audience-resolve-mapper	da27507b-edfa-44f4-a2f0-a94225bea092	\N
b5dc3c08-b352-4bd9-a3a5-ba60ca987f16	role list	saml	saml-role-list-mapper	\N	28983cdd-e6e4-4396-9943-f8a37f34c461
f07c891c-9f04-49f8-8817-262b551e2a29	full name	openid-connect	oidc-full-name-mapper	\N	668bf349-0426-4c6f-becc-739acc709266
78608f09-2681-4139-ac51-105eb3da9d33	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	668bf349-0426-4c6f-becc-739acc709266
5b2ecb10-c114-4515-a79d-5d2d26eb9837	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	668bf349-0426-4c6f-becc-739acc709266
2d9258bb-6119-4f43-8491-342d58404639	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	668bf349-0426-4c6f-becc-739acc709266
72e280c7-0ec3-474a-a465-3cfc3432d0a8	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	668bf349-0426-4c6f-becc-739acc709266
415dd9cb-6c63-495c-bfa4-8a15eb19bfe0	username	openid-connect	oidc-usermodel-attribute-mapper	\N	668bf349-0426-4c6f-becc-739acc709266
449327d3-abc4-469a-be4a-2a52691b6315	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	668bf349-0426-4c6f-becc-739acc709266
d8b39e83-dc92-41e6-8f50-f71a869ac148	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	668bf349-0426-4c6f-becc-739acc709266
af379402-0b7e-4b27-a6b9-e133271a2f80	website	openid-connect	oidc-usermodel-attribute-mapper	\N	668bf349-0426-4c6f-becc-739acc709266
88c85e50-fc26-4e71-b36c-3d9268c85087	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	668bf349-0426-4c6f-becc-739acc709266
49e1c04e-1558-4385-89bd-9b4a799c0a31	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	668bf349-0426-4c6f-becc-739acc709266
bd0ae544-feb0-4ca8-838f-a79bf52255b6	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	668bf349-0426-4c6f-becc-739acc709266
4887231a-bc8a-426c-815f-53231c4a6656	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	668bf349-0426-4c6f-becc-739acc709266
ce24dae0-8311-48c0-ab49-aadde9ece72f	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	668bf349-0426-4c6f-becc-739acc709266
704651ab-c459-4479-bf66-8af4dd926410	email	openid-connect	oidc-usermodel-attribute-mapper	\N	edde022c-b83b-4ecd-9c2c-9e739d615cde
f53ebd9d-bb25-4b18-9e03-3abbb7abe2ac	email verified	openid-connect	oidc-usermodel-property-mapper	\N	edde022c-b83b-4ecd-9c2c-9e739d615cde
6c066588-1243-4fb2-940a-caff2de0f4cb	address	openid-connect	oidc-address-mapper	\N	b19faed9-8fd5-481a-92f7-80add32df9d9
7d0e1a3b-1bb9-46a1-b402-a0a439055746	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	3bcb8921-7c43-4de0-afb1-bb3824cfd8b0
7687077c-deac-43ff-98d2-d781729189ab	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	3bcb8921-7c43-4de0-afb1-bb3824cfd8b0
6fc3ad87-c5d4-4c73-b7ca-8f002a19f5d1	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	4b3b68dd-ec00-41b3-9759-67badc56bb37
51931713-18d6-4cd1-91ac-591888a7bbcc	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	4b3b68dd-ec00-41b3-9759-67badc56bb37
cde047c6-1150-4d92-8f97-73990f13e814	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	4b3b68dd-ec00-41b3-9759-67badc56bb37
3e2b92e5-e09c-41ee-9a2c-efd17131e500	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	bada85d6-c053-4101-8d0f-eda3c2568cbf
712ff21c-1f69-458f-bf1e-cea9fc11fd75	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	df7770fb-fd2d-49db-a646-dd97f34e8b6f
aa799d43-eb13-4e33-a914-04996198be8b	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	df7770fb-fd2d-49db-a646-dd97f34e8b6f
009502f1-46c4-48e2-9515-7a516f34a09f	acr loa level	openid-connect	oidc-acr-mapper	\N	388e2005-f8e4-45ff-9980-7c7485577ac1
dad0f72c-9ad2-4b7c-8afd-a2484749723d	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	4fa1b3b7-b92e-4909-ad74-dc55efe4737d
ef727bf4-3621-4b1b-b70c-71a8628c2237	sub	openid-connect	oidc-sub-mapper	\N	4fa1b3b7-b92e-4909-ad74-dc55efe4737d
9673b7ce-96ce-4431-97f0-00b34bdf4407	locale	openid-connect	oidc-usermodel-attribute-mapper	faf611cc-6822-4e45-a870-a0b9360b785c	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
75bebd6e-4879-45f4-bf65-8f2a68f9e102	true	introspection.token.claim
75bebd6e-4879-45f4-bf65-8f2a68f9e102	true	userinfo.token.claim
75bebd6e-4879-45f4-bf65-8f2a68f9e102	locale	user.attribute
75bebd6e-4879-45f4-bf65-8f2a68f9e102	true	id.token.claim
75bebd6e-4879-45f4-bf65-8f2a68f9e102	true	access.token.claim
75bebd6e-4879-45f4-bf65-8f2a68f9e102	locale	claim.name
75bebd6e-4879-45f4-bf65-8f2a68f9e102	String	jsonType.label
03dc90a1-f8e0-43ac-8964-4e3bcd431e35	false	single
03dc90a1-f8e0-43ac-8964-4e3bcd431e35	Basic	attribute.nameformat
03dc90a1-f8e0-43ac-8964-4e3bcd431e35	Role	attribute.name
0d318434-808a-4a28-89be-03663e1a250b	true	introspection.token.claim
0d318434-808a-4a28-89be-03663e1a250b	true	userinfo.token.claim
0d318434-808a-4a28-89be-03663e1a250b	picture	user.attribute
0d318434-808a-4a28-89be-03663e1a250b	true	id.token.claim
0d318434-808a-4a28-89be-03663e1a250b	true	access.token.claim
0d318434-808a-4a28-89be-03663e1a250b	picture	claim.name
0d318434-808a-4a28-89be-03663e1a250b	String	jsonType.label
19be34f5-cc24-4a57-9f5f-23b8f9e07d07	true	introspection.token.claim
19be34f5-cc24-4a57-9f5f-23b8f9e07d07	true	userinfo.token.claim
19be34f5-cc24-4a57-9f5f-23b8f9e07d07	lastName	user.attribute
19be34f5-cc24-4a57-9f5f-23b8f9e07d07	true	id.token.claim
19be34f5-cc24-4a57-9f5f-23b8f9e07d07	true	access.token.claim
19be34f5-cc24-4a57-9f5f-23b8f9e07d07	family_name	claim.name
19be34f5-cc24-4a57-9f5f-23b8f9e07d07	String	jsonType.label
2a8f0c47-d241-443b-907f-5f95849cfb5a	true	introspection.token.claim
2a8f0c47-d241-443b-907f-5f95849cfb5a	true	userinfo.token.claim
2a8f0c47-d241-443b-907f-5f95849cfb5a	birthdate	user.attribute
2a8f0c47-d241-443b-907f-5f95849cfb5a	true	id.token.claim
2a8f0c47-d241-443b-907f-5f95849cfb5a	true	access.token.claim
2a8f0c47-d241-443b-907f-5f95849cfb5a	birthdate	claim.name
2a8f0c47-d241-443b-907f-5f95849cfb5a	String	jsonType.label
3b5e73d2-ef7b-49dd-9beb-76f0f7d95a49	true	introspection.token.claim
3b5e73d2-ef7b-49dd-9beb-76f0f7d95a49	true	userinfo.token.claim
3b5e73d2-ef7b-49dd-9beb-76f0f7d95a49	locale	user.attribute
3b5e73d2-ef7b-49dd-9beb-76f0f7d95a49	true	id.token.claim
3b5e73d2-ef7b-49dd-9beb-76f0f7d95a49	true	access.token.claim
3b5e73d2-ef7b-49dd-9beb-76f0f7d95a49	locale	claim.name
3b5e73d2-ef7b-49dd-9beb-76f0f7d95a49	String	jsonType.label
405b0cd9-175c-4b6d-84d3-eae32f4dc5c9	true	introspection.token.claim
405b0cd9-175c-4b6d-84d3-eae32f4dc5c9	true	userinfo.token.claim
405b0cd9-175c-4b6d-84d3-eae32f4dc5c9	middleName	user.attribute
405b0cd9-175c-4b6d-84d3-eae32f4dc5c9	true	id.token.claim
405b0cd9-175c-4b6d-84d3-eae32f4dc5c9	true	access.token.claim
405b0cd9-175c-4b6d-84d3-eae32f4dc5c9	middle_name	claim.name
405b0cd9-175c-4b6d-84d3-eae32f4dc5c9	String	jsonType.label
65386236-4bf5-47e3-844c-2bb74ff0ae7d	true	introspection.token.claim
65386236-4bf5-47e3-844c-2bb74ff0ae7d	true	userinfo.token.claim
65386236-4bf5-47e3-844c-2bb74ff0ae7d	true	id.token.claim
65386236-4bf5-47e3-844c-2bb74ff0ae7d	true	access.token.claim
6653f451-0dbb-4e52-b874-a2f959f35764	true	introspection.token.claim
6653f451-0dbb-4e52-b874-a2f959f35764	true	userinfo.token.claim
6653f451-0dbb-4e52-b874-a2f959f35764	nickname	user.attribute
6653f451-0dbb-4e52-b874-a2f959f35764	true	id.token.claim
6653f451-0dbb-4e52-b874-a2f959f35764	true	access.token.claim
6653f451-0dbb-4e52-b874-a2f959f35764	nickname	claim.name
6653f451-0dbb-4e52-b874-a2f959f35764	String	jsonType.label
72360a10-7658-425e-9440-515868812955	true	introspection.token.claim
72360a10-7658-425e-9440-515868812955	true	userinfo.token.claim
72360a10-7658-425e-9440-515868812955	profile	user.attribute
72360a10-7658-425e-9440-515868812955	true	id.token.claim
72360a10-7658-425e-9440-515868812955	true	access.token.claim
72360a10-7658-425e-9440-515868812955	profile	claim.name
72360a10-7658-425e-9440-515868812955	String	jsonType.label
847c8447-87f3-4d69-8a17-de196f30255e	true	introspection.token.claim
847c8447-87f3-4d69-8a17-de196f30255e	true	userinfo.token.claim
847c8447-87f3-4d69-8a17-de196f30255e	gender	user.attribute
847c8447-87f3-4d69-8a17-de196f30255e	true	id.token.claim
847c8447-87f3-4d69-8a17-de196f30255e	true	access.token.claim
847c8447-87f3-4d69-8a17-de196f30255e	gender	claim.name
847c8447-87f3-4d69-8a17-de196f30255e	String	jsonType.label
9fc6d9ae-25c6-4fc5-8051-64fbb832a654	true	introspection.token.claim
9fc6d9ae-25c6-4fc5-8051-64fbb832a654	true	userinfo.token.claim
9fc6d9ae-25c6-4fc5-8051-64fbb832a654	updatedAt	user.attribute
9fc6d9ae-25c6-4fc5-8051-64fbb832a654	true	id.token.claim
9fc6d9ae-25c6-4fc5-8051-64fbb832a654	true	access.token.claim
9fc6d9ae-25c6-4fc5-8051-64fbb832a654	updated_at	claim.name
9fc6d9ae-25c6-4fc5-8051-64fbb832a654	long	jsonType.label
a4550e86-f242-487e-a29a-fc192e81ba20	true	introspection.token.claim
a4550e86-f242-487e-a29a-fc192e81ba20	true	userinfo.token.claim
a4550e86-f242-487e-a29a-fc192e81ba20	zoneinfo	user.attribute
a4550e86-f242-487e-a29a-fc192e81ba20	true	id.token.claim
a4550e86-f242-487e-a29a-fc192e81ba20	true	access.token.claim
a4550e86-f242-487e-a29a-fc192e81ba20	zoneinfo	claim.name
a4550e86-f242-487e-a29a-fc192e81ba20	String	jsonType.label
c09be8e4-830c-4537-b12f-64f698cc5a04	true	introspection.token.claim
c09be8e4-830c-4537-b12f-64f698cc5a04	true	userinfo.token.claim
c09be8e4-830c-4537-b12f-64f698cc5a04	website	user.attribute
c09be8e4-830c-4537-b12f-64f698cc5a04	true	id.token.claim
c09be8e4-830c-4537-b12f-64f698cc5a04	true	access.token.claim
c09be8e4-830c-4537-b12f-64f698cc5a04	website	claim.name
c09be8e4-830c-4537-b12f-64f698cc5a04	String	jsonType.label
c5080530-dd0e-4571-b710-b0449e906f6c	true	introspection.token.claim
c5080530-dd0e-4571-b710-b0449e906f6c	true	userinfo.token.claim
c5080530-dd0e-4571-b710-b0449e906f6c	username	user.attribute
c5080530-dd0e-4571-b710-b0449e906f6c	true	id.token.claim
c5080530-dd0e-4571-b710-b0449e906f6c	true	access.token.claim
c5080530-dd0e-4571-b710-b0449e906f6c	preferred_username	claim.name
c5080530-dd0e-4571-b710-b0449e906f6c	String	jsonType.label
ef1e6add-8b4b-4fca-8b0c-9ab06c26a1b8	true	introspection.token.claim
ef1e6add-8b4b-4fca-8b0c-9ab06c26a1b8	true	userinfo.token.claim
ef1e6add-8b4b-4fca-8b0c-9ab06c26a1b8	firstName	user.attribute
ef1e6add-8b4b-4fca-8b0c-9ab06c26a1b8	true	id.token.claim
ef1e6add-8b4b-4fca-8b0c-9ab06c26a1b8	true	access.token.claim
ef1e6add-8b4b-4fca-8b0c-9ab06c26a1b8	given_name	claim.name
ef1e6add-8b4b-4fca-8b0c-9ab06c26a1b8	String	jsonType.label
81586885-28ca-465f-aec3-21fdfebc71e3	true	introspection.token.claim
81586885-28ca-465f-aec3-21fdfebc71e3	true	userinfo.token.claim
81586885-28ca-465f-aec3-21fdfebc71e3	emailVerified	user.attribute
81586885-28ca-465f-aec3-21fdfebc71e3	true	id.token.claim
81586885-28ca-465f-aec3-21fdfebc71e3	true	access.token.claim
81586885-28ca-465f-aec3-21fdfebc71e3	email_verified	claim.name
81586885-28ca-465f-aec3-21fdfebc71e3	boolean	jsonType.label
a6388573-8c9d-4b2c-8fe4-dffdbda5f6db	true	introspection.token.claim
a6388573-8c9d-4b2c-8fe4-dffdbda5f6db	true	userinfo.token.claim
a6388573-8c9d-4b2c-8fe4-dffdbda5f6db	email	user.attribute
a6388573-8c9d-4b2c-8fe4-dffdbda5f6db	true	id.token.claim
a6388573-8c9d-4b2c-8fe4-dffdbda5f6db	true	access.token.claim
a6388573-8c9d-4b2c-8fe4-dffdbda5f6db	email	claim.name
a6388573-8c9d-4b2c-8fe4-dffdbda5f6db	String	jsonType.label
aa5e155b-0a68-4262-9d1d-c454bb780fe7	formatted	user.attribute.formatted
aa5e155b-0a68-4262-9d1d-c454bb780fe7	country	user.attribute.country
aa5e155b-0a68-4262-9d1d-c454bb780fe7	true	introspection.token.claim
aa5e155b-0a68-4262-9d1d-c454bb780fe7	postal_code	user.attribute.postal_code
aa5e155b-0a68-4262-9d1d-c454bb780fe7	true	userinfo.token.claim
aa5e155b-0a68-4262-9d1d-c454bb780fe7	street	user.attribute.street
aa5e155b-0a68-4262-9d1d-c454bb780fe7	true	id.token.claim
aa5e155b-0a68-4262-9d1d-c454bb780fe7	region	user.attribute.region
aa5e155b-0a68-4262-9d1d-c454bb780fe7	true	access.token.claim
aa5e155b-0a68-4262-9d1d-c454bb780fe7	locality	user.attribute.locality
323ce640-ce0e-4f00-859b-dc39feed27c9	true	introspection.token.claim
323ce640-ce0e-4f00-859b-dc39feed27c9	true	userinfo.token.claim
323ce640-ce0e-4f00-859b-dc39feed27c9	phoneNumberVerified	user.attribute
323ce640-ce0e-4f00-859b-dc39feed27c9	true	id.token.claim
323ce640-ce0e-4f00-859b-dc39feed27c9	true	access.token.claim
323ce640-ce0e-4f00-859b-dc39feed27c9	phone_number_verified	claim.name
323ce640-ce0e-4f00-859b-dc39feed27c9	boolean	jsonType.label
da1f394e-2bb8-466b-b753-c5878b15479d	true	introspection.token.claim
da1f394e-2bb8-466b-b753-c5878b15479d	true	userinfo.token.claim
da1f394e-2bb8-466b-b753-c5878b15479d	phoneNumber	user.attribute
da1f394e-2bb8-466b-b753-c5878b15479d	true	id.token.claim
da1f394e-2bb8-466b-b753-c5878b15479d	true	access.token.claim
da1f394e-2bb8-466b-b753-c5878b15479d	phone_number	claim.name
da1f394e-2bb8-466b-b753-c5878b15479d	String	jsonType.label
51ddd7ca-0b6e-4145-879e-7731c216fa8d	true	introspection.token.claim
51ddd7ca-0b6e-4145-879e-7731c216fa8d	true	access.token.claim
9569422a-d430-4665-aada-eefc5481aaff	true	introspection.token.claim
9569422a-d430-4665-aada-eefc5481aaff	true	multivalued
9569422a-d430-4665-aada-eefc5481aaff	foo	user.attribute
9569422a-d430-4665-aada-eefc5481aaff	true	access.token.claim
9569422a-d430-4665-aada-eefc5481aaff	resource_access.${client_id}.roles	claim.name
9569422a-d430-4665-aada-eefc5481aaff	String	jsonType.label
d531f0bb-6cf3-478d-ad0a-96790cb7fef4	true	introspection.token.claim
d531f0bb-6cf3-478d-ad0a-96790cb7fef4	true	multivalued
d531f0bb-6cf3-478d-ad0a-96790cb7fef4	foo	user.attribute
d531f0bb-6cf3-478d-ad0a-96790cb7fef4	true	access.token.claim
d531f0bb-6cf3-478d-ad0a-96790cb7fef4	realm_access.roles	claim.name
d531f0bb-6cf3-478d-ad0a-96790cb7fef4	String	jsonType.label
b17fb4b1-1897-4640-ad07-a46d47474769	true	introspection.token.claim
b17fb4b1-1897-4640-ad07-a46d47474769	true	access.token.claim
d1a9b576-38de-44c3-912c-728a7be52b12	true	introspection.token.claim
d1a9b576-38de-44c3-912c-728a7be52b12	true	multivalued
d1a9b576-38de-44c3-912c-728a7be52b12	foo	user.attribute
d1a9b576-38de-44c3-912c-728a7be52b12	true	id.token.claim
d1a9b576-38de-44c3-912c-728a7be52b12	true	access.token.claim
d1a9b576-38de-44c3-912c-728a7be52b12	groups	claim.name
d1a9b576-38de-44c3-912c-728a7be52b12	String	jsonType.label
d5d96703-cfbc-4c22-abb3-41f6010f6882	true	introspection.token.claim
d5d96703-cfbc-4c22-abb3-41f6010f6882	true	userinfo.token.claim
d5d96703-cfbc-4c22-abb3-41f6010f6882	username	user.attribute
d5d96703-cfbc-4c22-abb3-41f6010f6882	true	id.token.claim
d5d96703-cfbc-4c22-abb3-41f6010f6882	true	access.token.claim
d5d96703-cfbc-4c22-abb3-41f6010f6882	upn	claim.name
d5d96703-cfbc-4c22-abb3-41f6010f6882	String	jsonType.label
18d037b3-8254-4034-999c-19bf23572564	true	introspection.token.claim
18d037b3-8254-4034-999c-19bf23572564	true	id.token.claim
18d037b3-8254-4034-999c-19bf23572564	true	access.token.claim
26a4b2a0-15fd-4d1a-9961-f71bafb994aa	AUTH_TIME	user.session.note
26a4b2a0-15fd-4d1a-9961-f71bafb994aa	true	introspection.token.claim
26a4b2a0-15fd-4d1a-9961-f71bafb994aa	true	id.token.claim
26a4b2a0-15fd-4d1a-9961-f71bafb994aa	true	access.token.claim
26a4b2a0-15fd-4d1a-9961-f71bafb994aa	auth_time	claim.name
26a4b2a0-15fd-4d1a-9961-f71bafb994aa	long	jsonType.label
ac858d80-dcab-4078-b700-a2d1ab4e6bb0	true	introspection.token.claim
ac858d80-dcab-4078-b700-a2d1ab4e6bb0	true	access.token.claim
b5dc3c08-b352-4bd9-a3a5-ba60ca987f16	false	single
b5dc3c08-b352-4bd9-a3a5-ba60ca987f16	Basic	attribute.nameformat
b5dc3c08-b352-4bd9-a3a5-ba60ca987f16	Role	attribute.name
2d9258bb-6119-4f43-8491-342d58404639	true	introspection.token.claim
2d9258bb-6119-4f43-8491-342d58404639	true	userinfo.token.claim
2d9258bb-6119-4f43-8491-342d58404639	middleName	user.attribute
2d9258bb-6119-4f43-8491-342d58404639	true	id.token.claim
2d9258bb-6119-4f43-8491-342d58404639	true	access.token.claim
2d9258bb-6119-4f43-8491-342d58404639	middle_name	claim.name
2d9258bb-6119-4f43-8491-342d58404639	String	jsonType.label
415dd9cb-6c63-495c-bfa4-8a15eb19bfe0	true	introspection.token.claim
415dd9cb-6c63-495c-bfa4-8a15eb19bfe0	true	userinfo.token.claim
415dd9cb-6c63-495c-bfa4-8a15eb19bfe0	username	user.attribute
415dd9cb-6c63-495c-bfa4-8a15eb19bfe0	true	id.token.claim
415dd9cb-6c63-495c-bfa4-8a15eb19bfe0	true	access.token.claim
415dd9cb-6c63-495c-bfa4-8a15eb19bfe0	preferred_username	claim.name
415dd9cb-6c63-495c-bfa4-8a15eb19bfe0	String	jsonType.label
449327d3-abc4-469a-be4a-2a52691b6315	true	introspection.token.claim
449327d3-abc4-469a-be4a-2a52691b6315	true	userinfo.token.claim
449327d3-abc4-469a-be4a-2a52691b6315	profile	user.attribute
449327d3-abc4-469a-be4a-2a52691b6315	true	id.token.claim
449327d3-abc4-469a-be4a-2a52691b6315	true	access.token.claim
449327d3-abc4-469a-be4a-2a52691b6315	profile	claim.name
449327d3-abc4-469a-be4a-2a52691b6315	String	jsonType.label
4887231a-bc8a-426c-815f-53231c4a6656	true	introspection.token.claim
4887231a-bc8a-426c-815f-53231c4a6656	true	userinfo.token.claim
4887231a-bc8a-426c-815f-53231c4a6656	locale	user.attribute
4887231a-bc8a-426c-815f-53231c4a6656	true	id.token.claim
4887231a-bc8a-426c-815f-53231c4a6656	true	access.token.claim
4887231a-bc8a-426c-815f-53231c4a6656	locale	claim.name
4887231a-bc8a-426c-815f-53231c4a6656	String	jsonType.label
49e1c04e-1558-4385-89bd-9b4a799c0a31	true	introspection.token.claim
49e1c04e-1558-4385-89bd-9b4a799c0a31	true	userinfo.token.claim
49e1c04e-1558-4385-89bd-9b4a799c0a31	birthdate	user.attribute
49e1c04e-1558-4385-89bd-9b4a799c0a31	true	id.token.claim
49e1c04e-1558-4385-89bd-9b4a799c0a31	true	access.token.claim
49e1c04e-1558-4385-89bd-9b4a799c0a31	birthdate	claim.name
49e1c04e-1558-4385-89bd-9b4a799c0a31	String	jsonType.label
5b2ecb10-c114-4515-a79d-5d2d26eb9837	true	introspection.token.claim
5b2ecb10-c114-4515-a79d-5d2d26eb9837	true	userinfo.token.claim
5b2ecb10-c114-4515-a79d-5d2d26eb9837	firstName	user.attribute
5b2ecb10-c114-4515-a79d-5d2d26eb9837	true	id.token.claim
5b2ecb10-c114-4515-a79d-5d2d26eb9837	true	access.token.claim
5b2ecb10-c114-4515-a79d-5d2d26eb9837	given_name	claim.name
5b2ecb10-c114-4515-a79d-5d2d26eb9837	String	jsonType.label
72e280c7-0ec3-474a-a465-3cfc3432d0a8	true	introspection.token.claim
72e280c7-0ec3-474a-a465-3cfc3432d0a8	true	userinfo.token.claim
72e280c7-0ec3-474a-a465-3cfc3432d0a8	nickname	user.attribute
72e280c7-0ec3-474a-a465-3cfc3432d0a8	true	id.token.claim
72e280c7-0ec3-474a-a465-3cfc3432d0a8	true	access.token.claim
72e280c7-0ec3-474a-a465-3cfc3432d0a8	nickname	claim.name
72e280c7-0ec3-474a-a465-3cfc3432d0a8	String	jsonType.label
78608f09-2681-4139-ac51-105eb3da9d33	true	introspection.token.claim
78608f09-2681-4139-ac51-105eb3da9d33	true	userinfo.token.claim
78608f09-2681-4139-ac51-105eb3da9d33	lastName	user.attribute
78608f09-2681-4139-ac51-105eb3da9d33	true	id.token.claim
78608f09-2681-4139-ac51-105eb3da9d33	true	access.token.claim
78608f09-2681-4139-ac51-105eb3da9d33	family_name	claim.name
78608f09-2681-4139-ac51-105eb3da9d33	String	jsonType.label
88c85e50-fc26-4e71-b36c-3d9268c85087	true	introspection.token.claim
88c85e50-fc26-4e71-b36c-3d9268c85087	true	userinfo.token.claim
88c85e50-fc26-4e71-b36c-3d9268c85087	gender	user.attribute
88c85e50-fc26-4e71-b36c-3d9268c85087	true	id.token.claim
88c85e50-fc26-4e71-b36c-3d9268c85087	true	access.token.claim
88c85e50-fc26-4e71-b36c-3d9268c85087	gender	claim.name
88c85e50-fc26-4e71-b36c-3d9268c85087	String	jsonType.label
af379402-0b7e-4b27-a6b9-e133271a2f80	true	introspection.token.claim
af379402-0b7e-4b27-a6b9-e133271a2f80	true	userinfo.token.claim
af379402-0b7e-4b27-a6b9-e133271a2f80	website	user.attribute
af379402-0b7e-4b27-a6b9-e133271a2f80	true	id.token.claim
af379402-0b7e-4b27-a6b9-e133271a2f80	true	access.token.claim
af379402-0b7e-4b27-a6b9-e133271a2f80	website	claim.name
af379402-0b7e-4b27-a6b9-e133271a2f80	String	jsonType.label
bd0ae544-feb0-4ca8-838f-a79bf52255b6	true	introspection.token.claim
bd0ae544-feb0-4ca8-838f-a79bf52255b6	true	userinfo.token.claim
bd0ae544-feb0-4ca8-838f-a79bf52255b6	zoneinfo	user.attribute
bd0ae544-feb0-4ca8-838f-a79bf52255b6	true	id.token.claim
bd0ae544-feb0-4ca8-838f-a79bf52255b6	true	access.token.claim
bd0ae544-feb0-4ca8-838f-a79bf52255b6	zoneinfo	claim.name
bd0ae544-feb0-4ca8-838f-a79bf52255b6	String	jsonType.label
ce24dae0-8311-48c0-ab49-aadde9ece72f	true	introspection.token.claim
ce24dae0-8311-48c0-ab49-aadde9ece72f	true	userinfo.token.claim
ce24dae0-8311-48c0-ab49-aadde9ece72f	updatedAt	user.attribute
ce24dae0-8311-48c0-ab49-aadde9ece72f	true	id.token.claim
ce24dae0-8311-48c0-ab49-aadde9ece72f	true	access.token.claim
ce24dae0-8311-48c0-ab49-aadde9ece72f	updated_at	claim.name
ce24dae0-8311-48c0-ab49-aadde9ece72f	long	jsonType.label
d8b39e83-dc92-41e6-8f50-f71a869ac148	true	introspection.token.claim
d8b39e83-dc92-41e6-8f50-f71a869ac148	true	userinfo.token.claim
d8b39e83-dc92-41e6-8f50-f71a869ac148	picture	user.attribute
d8b39e83-dc92-41e6-8f50-f71a869ac148	true	id.token.claim
d8b39e83-dc92-41e6-8f50-f71a869ac148	true	access.token.claim
d8b39e83-dc92-41e6-8f50-f71a869ac148	picture	claim.name
d8b39e83-dc92-41e6-8f50-f71a869ac148	String	jsonType.label
f07c891c-9f04-49f8-8817-262b551e2a29	true	introspection.token.claim
f07c891c-9f04-49f8-8817-262b551e2a29	true	userinfo.token.claim
f07c891c-9f04-49f8-8817-262b551e2a29	true	id.token.claim
f07c891c-9f04-49f8-8817-262b551e2a29	true	access.token.claim
704651ab-c459-4479-bf66-8af4dd926410	true	introspection.token.claim
704651ab-c459-4479-bf66-8af4dd926410	true	userinfo.token.claim
704651ab-c459-4479-bf66-8af4dd926410	email	user.attribute
704651ab-c459-4479-bf66-8af4dd926410	true	id.token.claim
704651ab-c459-4479-bf66-8af4dd926410	true	access.token.claim
704651ab-c459-4479-bf66-8af4dd926410	email	claim.name
704651ab-c459-4479-bf66-8af4dd926410	String	jsonType.label
f53ebd9d-bb25-4b18-9e03-3abbb7abe2ac	true	introspection.token.claim
f53ebd9d-bb25-4b18-9e03-3abbb7abe2ac	true	userinfo.token.claim
f53ebd9d-bb25-4b18-9e03-3abbb7abe2ac	emailVerified	user.attribute
f53ebd9d-bb25-4b18-9e03-3abbb7abe2ac	true	id.token.claim
f53ebd9d-bb25-4b18-9e03-3abbb7abe2ac	true	access.token.claim
f53ebd9d-bb25-4b18-9e03-3abbb7abe2ac	email_verified	claim.name
f53ebd9d-bb25-4b18-9e03-3abbb7abe2ac	boolean	jsonType.label
6c066588-1243-4fb2-940a-caff2de0f4cb	formatted	user.attribute.formatted
6c066588-1243-4fb2-940a-caff2de0f4cb	country	user.attribute.country
6c066588-1243-4fb2-940a-caff2de0f4cb	true	introspection.token.claim
6c066588-1243-4fb2-940a-caff2de0f4cb	postal_code	user.attribute.postal_code
6c066588-1243-4fb2-940a-caff2de0f4cb	true	userinfo.token.claim
6c066588-1243-4fb2-940a-caff2de0f4cb	street	user.attribute.street
6c066588-1243-4fb2-940a-caff2de0f4cb	true	id.token.claim
6c066588-1243-4fb2-940a-caff2de0f4cb	region	user.attribute.region
6c066588-1243-4fb2-940a-caff2de0f4cb	true	access.token.claim
6c066588-1243-4fb2-940a-caff2de0f4cb	locality	user.attribute.locality
7687077c-deac-43ff-98d2-d781729189ab	true	introspection.token.claim
7687077c-deac-43ff-98d2-d781729189ab	true	userinfo.token.claim
7687077c-deac-43ff-98d2-d781729189ab	phoneNumberVerified	user.attribute
7687077c-deac-43ff-98d2-d781729189ab	true	id.token.claim
7687077c-deac-43ff-98d2-d781729189ab	true	access.token.claim
7687077c-deac-43ff-98d2-d781729189ab	phone_number_verified	claim.name
7687077c-deac-43ff-98d2-d781729189ab	boolean	jsonType.label
7d0e1a3b-1bb9-46a1-b402-a0a439055746	true	introspection.token.claim
7d0e1a3b-1bb9-46a1-b402-a0a439055746	true	userinfo.token.claim
7d0e1a3b-1bb9-46a1-b402-a0a439055746	phoneNumber	user.attribute
7d0e1a3b-1bb9-46a1-b402-a0a439055746	true	id.token.claim
7d0e1a3b-1bb9-46a1-b402-a0a439055746	true	access.token.claim
7d0e1a3b-1bb9-46a1-b402-a0a439055746	phone_number	claim.name
7d0e1a3b-1bb9-46a1-b402-a0a439055746	String	jsonType.label
51931713-18d6-4cd1-91ac-591888a7bbcc	true	introspection.token.claim
51931713-18d6-4cd1-91ac-591888a7bbcc	true	multivalued
51931713-18d6-4cd1-91ac-591888a7bbcc	foo	user.attribute
51931713-18d6-4cd1-91ac-591888a7bbcc	true	access.token.claim
51931713-18d6-4cd1-91ac-591888a7bbcc	resource_access.${client_id}.roles	claim.name
51931713-18d6-4cd1-91ac-591888a7bbcc	String	jsonType.label
6fc3ad87-c5d4-4c73-b7ca-8f002a19f5d1	true	introspection.token.claim
6fc3ad87-c5d4-4c73-b7ca-8f002a19f5d1	true	multivalued
6fc3ad87-c5d4-4c73-b7ca-8f002a19f5d1	foo	user.attribute
6fc3ad87-c5d4-4c73-b7ca-8f002a19f5d1	true	access.token.claim
6fc3ad87-c5d4-4c73-b7ca-8f002a19f5d1	realm_access.roles	claim.name
6fc3ad87-c5d4-4c73-b7ca-8f002a19f5d1	String	jsonType.label
cde047c6-1150-4d92-8f97-73990f13e814	true	introspection.token.claim
cde047c6-1150-4d92-8f97-73990f13e814	true	access.token.claim
3e2b92e5-e09c-41ee-9a2c-efd17131e500	true	introspection.token.claim
3e2b92e5-e09c-41ee-9a2c-efd17131e500	true	access.token.claim
712ff21c-1f69-458f-bf1e-cea9fc11fd75	true	introspection.token.claim
712ff21c-1f69-458f-bf1e-cea9fc11fd75	true	userinfo.token.claim
712ff21c-1f69-458f-bf1e-cea9fc11fd75	username	user.attribute
712ff21c-1f69-458f-bf1e-cea9fc11fd75	true	id.token.claim
712ff21c-1f69-458f-bf1e-cea9fc11fd75	true	access.token.claim
712ff21c-1f69-458f-bf1e-cea9fc11fd75	upn	claim.name
712ff21c-1f69-458f-bf1e-cea9fc11fd75	String	jsonType.label
aa799d43-eb13-4e33-a914-04996198be8b	true	introspection.token.claim
aa799d43-eb13-4e33-a914-04996198be8b	true	multivalued
aa799d43-eb13-4e33-a914-04996198be8b	foo	user.attribute
aa799d43-eb13-4e33-a914-04996198be8b	true	id.token.claim
aa799d43-eb13-4e33-a914-04996198be8b	true	access.token.claim
aa799d43-eb13-4e33-a914-04996198be8b	groups	claim.name
aa799d43-eb13-4e33-a914-04996198be8b	String	jsonType.label
009502f1-46c4-48e2-9515-7a516f34a09f	true	introspection.token.claim
009502f1-46c4-48e2-9515-7a516f34a09f	true	id.token.claim
009502f1-46c4-48e2-9515-7a516f34a09f	true	access.token.claim
dad0f72c-9ad2-4b7c-8afd-a2484749723d	AUTH_TIME	user.session.note
dad0f72c-9ad2-4b7c-8afd-a2484749723d	true	introspection.token.claim
dad0f72c-9ad2-4b7c-8afd-a2484749723d	true	id.token.claim
dad0f72c-9ad2-4b7c-8afd-a2484749723d	true	access.token.claim
dad0f72c-9ad2-4b7c-8afd-a2484749723d	auth_time	claim.name
dad0f72c-9ad2-4b7c-8afd-a2484749723d	long	jsonType.label
ef727bf4-3621-4b1b-b70c-71a8628c2237	true	introspection.token.claim
ef727bf4-3621-4b1b-b70c-71a8628c2237	true	access.token.claim
9673b7ce-96ce-4431-97f0-00b34bdf4407	true	introspection.token.claim
9673b7ce-96ce-4431-97f0-00b34bdf4407	true	userinfo.token.claim
9673b7ce-96ce-4431-97f0-00b34bdf4407	locale	user.attribute
9673b7ce-96ce-4431-97f0-00b34bdf4407	true	id.token.claim
9673b7ce-96ce-4431-97f0-00b34bdf4407	true	access.token.claim
9673b7ce-96ce-4431-97f0-00b34bdf4407	locale	claim.name
9673b7ce-96ce-4431-97f0-00b34bdf4407	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
2fc07f5a-9f12-47ad-8999-54ec21d06664	60	300	300	\N	\N	\N	t	f	0	\N	extranet-pp	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	6e404e1f-3d41-475f-9a88-8c14f663b4a2	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	2f28fe5e-1b4a-44ce-a9d3-91dca9e08b91	1f9d6f1a-f889-4c2c-a5c0-a3d4df0f253d	6ab06add-6064-442f-a9aa-ed19d461b72b	37a13e8c-997e-462e-86d5-67c3bba3971f	5545fd85-01bb-42a2-b10d-40a435c58fe3	2592000	f	900	t	f	a09d42c9-7292-4bc2-bd1c-fab27a6eabe3	0	f	0	0	f781624a-0d6d-416e-b697-5fa0cf347a2b
50f476a7-f350-43ba-8b98-a206554bea56	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	0d818e3a-2fb1-49da-938d-757867de28a5	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	dec4313b-a830-49fc-8017-e13fb8b9a259	4b14939b-0dd3-4007-b397-74e95019f410	69ecc80a-f114-4efb-b55f-f3a22363639f	ba229d13-958d-4d58-a1c3-37a8a251d965	2799b417-48c7-45cc-b11a-f0d46a0280f1	2592000	f	900	t	f	7f0fc537-bc20-46a2-b4e7-793080a6949c	0	f	0	0	b093f3d7-7842-4d76-b4df-af8ec109efd7
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	50f476a7-f350-43ba-8b98-a206554bea56	
_browser_header.xContentTypeOptions	50f476a7-f350-43ba-8b98-a206554bea56	nosniff
_browser_header.referrerPolicy	50f476a7-f350-43ba-8b98-a206554bea56	no-referrer
_browser_header.xRobotsTag	50f476a7-f350-43ba-8b98-a206554bea56	none
_browser_header.xFrameOptions	50f476a7-f350-43ba-8b98-a206554bea56	SAMEORIGIN
_browser_header.contentSecurityPolicy	50f476a7-f350-43ba-8b98-a206554bea56	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	50f476a7-f350-43ba-8b98-a206554bea56	1; mode=block
_browser_header.strictTransportSecurity	50f476a7-f350-43ba-8b98-a206554bea56	max-age=31536000; includeSubDomains
bruteForceProtected	50f476a7-f350-43ba-8b98-a206554bea56	false
permanentLockout	50f476a7-f350-43ba-8b98-a206554bea56	false
maxTemporaryLockouts	50f476a7-f350-43ba-8b98-a206554bea56	0
maxFailureWaitSeconds	50f476a7-f350-43ba-8b98-a206554bea56	900
minimumQuickLoginWaitSeconds	50f476a7-f350-43ba-8b98-a206554bea56	60
waitIncrementSeconds	50f476a7-f350-43ba-8b98-a206554bea56	60
quickLoginCheckMilliSeconds	50f476a7-f350-43ba-8b98-a206554bea56	1000
maxDeltaTimeSeconds	50f476a7-f350-43ba-8b98-a206554bea56	43200
failureFactor	50f476a7-f350-43ba-8b98-a206554bea56	30
realmReusableOtpCode	50f476a7-f350-43ba-8b98-a206554bea56	false
firstBrokerLoginFlowId	50f476a7-f350-43ba-8b98-a206554bea56	705bee5d-1cca-4055-8750-e4947b5e75b3
displayName	50f476a7-f350-43ba-8b98-a206554bea56	Keycloak
displayNameHtml	50f476a7-f350-43ba-8b98-a206554bea56	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	50f476a7-f350-43ba-8b98-a206554bea56	RS256
offlineSessionMaxLifespanEnabled	50f476a7-f350-43ba-8b98-a206554bea56	false
offlineSessionMaxLifespan	50f476a7-f350-43ba-8b98-a206554bea56	5184000
_browser_header.contentSecurityPolicyReportOnly	2fc07f5a-9f12-47ad-8999-54ec21d06664	
_browser_header.xContentTypeOptions	2fc07f5a-9f12-47ad-8999-54ec21d06664	nosniff
_browser_header.referrerPolicy	2fc07f5a-9f12-47ad-8999-54ec21d06664	no-referrer
_browser_header.xRobotsTag	2fc07f5a-9f12-47ad-8999-54ec21d06664	none
_browser_header.xFrameOptions	2fc07f5a-9f12-47ad-8999-54ec21d06664	SAMEORIGIN
_browser_header.contentSecurityPolicy	2fc07f5a-9f12-47ad-8999-54ec21d06664	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	2fc07f5a-9f12-47ad-8999-54ec21d06664	1; mode=block
_browser_header.strictTransportSecurity	2fc07f5a-9f12-47ad-8999-54ec21d06664	max-age=31536000; includeSubDomains
bruteForceProtected	2fc07f5a-9f12-47ad-8999-54ec21d06664	false
permanentLockout	2fc07f5a-9f12-47ad-8999-54ec21d06664	false
maxTemporaryLockouts	2fc07f5a-9f12-47ad-8999-54ec21d06664	0
maxFailureWaitSeconds	2fc07f5a-9f12-47ad-8999-54ec21d06664	900
minimumQuickLoginWaitSeconds	2fc07f5a-9f12-47ad-8999-54ec21d06664	60
waitIncrementSeconds	2fc07f5a-9f12-47ad-8999-54ec21d06664	60
quickLoginCheckMilliSeconds	2fc07f5a-9f12-47ad-8999-54ec21d06664	1000
maxDeltaTimeSeconds	2fc07f5a-9f12-47ad-8999-54ec21d06664	43200
failureFactor	2fc07f5a-9f12-47ad-8999-54ec21d06664	30
realmReusableOtpCode	2fc07f5a-9f12-47ad-8999-54ec21d06664	false
defaultSignatureAlgorithm	2fc07f5a-9f12-47ad-8999-54ec21d06664	RS256
offlineSessionMaxLifespanEnabled	2fc07f5a-9f12-47ad-8999-54ec21d06664	false
offlineSessionMaxLifespan	2fc07f5a-9f12-47ad-8999-54ec21d06664	5184000
actionTokenGeneratedByAdminLifespan	2fc07f5a-9f12-47ad-8999-54ec21d06664	43200
actionTokenGeneratedByUserLifespan	2fc07f5a-9f12-47ad-8999-54ec21d06664	300
oauth2DeviceCodeLifespan	2fc07f5a-9f12-47ad-8999-54ec21d06664	600
oauth2DevicePollingInterval	2fc07f5a-9f12-47ad-8999-54ec21d06664	5
webAuthnPolicyRpEntityName	2fc07f5a-9f12-47ad-8999-54ec21d06664	keycloak
webAuthnPolicySignatureAlgorithms	2fc07f5a-9f12-47ad-8999-54ec21d06664	ES256
webAuthnPolicyRpId	2fc07f5a-9f12-47ad-8999-54ec21d06664	
webAuthnPolicyAttestationConveyancePreference	2fc07f5a-9f12-47ad-8999-54ec21d06664	not specified
webAuthnPolicyAuthenticatorAttachment	2fc07f5a-9f12-47ad-8999-54ec21d06664	not specified
webAuthnPolicyRequireResidentKey	2fc07f5a-9f12-47ad-8999-54ec21d06664	not specified
webAuthnPolicyUserVerificationRequirement	2fc07f5a-9f12-47ad-8999-54ec21d06664	not specified
webAuthnPolicyCreateTimeout	2fc07f5a-9f12-47ad-8999-54ec21d06664	0
webAuthnPolicyAvoidSameAuthenticatorRegister	2fc07f5a-9f12-47ad-8999-54ec21d06664	false
webAuthnPolicyRpEntityNamePasswordless	2fc07f5a-9f12-47ad-8999-54ec21d06664	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	2fc07f5a-9f12-47ad-8999-54ec21d06664	ES256
webAuthnPolicyRpIdPasswordless	2fc07f5a-9f12-47ad-8999-54ec21d06664	
webAuthnPolicyAttestationConveyancePreferencePasswordless	2fc07f5a-9f12-47ad-8999-54ec21d06664	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	2fc07f5a-9f12-47ad-8999-54ec21d06664	not specified
webAuthnPolicyRequireResidentKeyPasswordless	2fc07f5a-9f12-47ad-8999-54ec21d06664	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	2fc07f5a-9f12-47ad-8999-54ec21d06664	not specified
webAuthnPolicyCreateTimeoutPasswordless	2fc07f5a-9f12-47ad-8999-54ec21d06664	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	2fc07f5a-9f12-47ad-8999-54ec21d06664	false
cibaBackchannelTokenDeliveryMode	2fc07f5a-9f12-47ad-8999-54ec21d06664	poll
cibaExpiresIn	2fc07f5a-9f12-47ad-8999-54ec21d06664	120
cibaInterval	2fc07f5a-9f12-47ad-8999-54ec21d06664	5
cibaAuthRequestedUserHint	2fc07f5a-9f12-47ad-8999-54ec21d06664	login_hint
parRequestUriLifespan	2fc07f5a-9f12-47ad-8999-54ec21d06664	60
firstBrokerLoginFlowId	2fc07f5a-9f12-47ad-8999-54ec21d06664	4ebef7b8-64de-4abe-895d-d54201bffb74
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
50f476a7-f350-43ba-8b98-a206554bea56	jboss-logging
2fc07f5a-9f12-47ad-8999-54ec21d06664	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	50f476a7-f350-43ba-8b98-a206554bea56
password	password	t	t	2fc07f5a-9f12-47ad-8999-54ec21d06664
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.redirect_uris (client_id, value) FROM stdin;
bfcbc2d9-28f2-41b3-ab8f-e3ec970dd844	/realms/master/account/*
dda90977-935d-46a5-9869-cf36a2ef0e96	/realms/master/account/*
88de62f1-8110-4f86-95b6-fb4df82ef163	/admin/master/console/*
120af667-e73e-4e08-a4e0-4d0207158d7c	/realms/extranet-pp/account/*
da27507b-edfa-44f4-a2f0-a94225bea092	/realms/extranet-pp/account/*
faf611cc-6822-4e45-a870-a0b9360b785c	/admin/extranet-pp/console/*
11ada4c6-3523-4a02-a7cf-2c3f06c7e176	http://localhost:8080/*
11ada4c6-3523-4a02-a7cf-2c3f06c7e176	http://localhost:8082/*
11ada4c6-3523-4a02-a7cf-2c3f06c7e176	http://localhost:3000/*
11ada4c6-3523-4a02-a7cf-2c3f06c7e176	http://localhost:3001/*
c123e002-011b-4645-ab5a-10d4b9929eff	http://localhost:3000/*
c123e002-011b-4645-ab5a-10d4b9929eff	http://localhost:3001/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
9f76e770-2ce7-4703-82e4-98493be10c2b	VERIFY_EMAIL	Verify Email	50f476a7-f350-43ba-8b98-a206554bea56	t	f	VERIFY_EMAIL	50
9ae2e07d-0b4d-4dd7-bda6-c93560c5cd7d	UPDATE_PROFILE	Update Profile	50f476a7-f350-43ba-8b98-a206554bea56	t	f	UPDATE_PROFILE	40
8683c4f5-449e-45b2-a710-531941625eac	CONFIGURE_TOTP	Configure OTP	50f476a7-f350-43ba-8b98-a206554bea56	t	f	CONFIGURE_TOTP	10
b01240d9-0346-4d0d-bbb2-35beeaecdc03	UPDATE_PASSWORD	Update Password	50f476a7-f350-43ba-8b98-a206554bea56	t	f	UPDATE_PASSWORD	30
5add3c03-d17c-449e-9e35-45ed250852e0	TERMS_AND_CONDITIONS	Terms and Conditions	50f476a7-f350-43ba-8b98-a206554bea56	f	f	TERMS_AND_CONDITIONS	20
4e0a84c0-558e-48b5-a500-fe5dcf0a25ef	delete_account	Delete Account	50f476a7-f350-43ba-8b98-a206554bea56	f	f	delete_account	60
90cf33ae-4ef5-4b3e-bc87-660a355e9aff	delete_credential	Delete Credential	50f476a7-f350-43ba-8b98-a206554bea56	t	f	delete_credential	100
9ccd1490-98bc-453b-84f0-8a3d53ef9218	update_user_locale	Update User Locale	50f476a7-f350-43ba-8b98-a206554bea56	t	f	update_user_locale	1000
ca2e2434-79d6-41e1-a98e-3beaf5d86e0f	webauthn-register	Webauthn Register	50f476a7-f350-43ba-8b98-a206554bea56	t	f	webauthn-register	70
84bac144-f2d7-4204-bdc0-5053ea325836	webauthn-register-passwordless	Webauthn Register Passwordless	50f476a7-f350-43ba-8b98-a206554bea56	t	f	webauthn-register-passwordless	80
dfa194ed-70c5-40e5-8f14-3ee96c01d456	VERIFY_PROFILE	Verify Profile	50f476a7-f350-43ba-8b98-a206554bea56	t	f	VERIFY_PROFILE	90
fbd94648-e070-470d-bf52-b8d7edc742b2	VERIFY_EMAIL	Verify Email	2fc07f5a-9f12-47ad-8999-54ec21d06664	t	f	VERIFY_EMAIL	50
9e5748eb-314c-4229-8628-7fcf924f1a4a	UPDATE_PROFILE	Update Profile	2fc07f5a-9f12-47ad-8999-54ec21d06664	t	f	UPDATE_PROFILE	40
a68a5cd8-6a8d-46f7-b33d-503878b80007	CONFIGURE_TOTP	Configure OTP	2fc07f5a-9f12-47ad-8999-54ec21d06664	t	f	CONFIGURE_TOTP	10
6c68bc70-d86d-4329-8e96-84882ef573a7	UPDATE_PASSWORD	Update Password	2fc07f5a-9f12-47ad-8999-54ec21d06664	t	f	UPDATE_PASSWORD	30
3d0474b2-040c-4a4b-a043-960069460754	TERMS_AND_CONDITIONS	Terms and Conditions	2fc07f5a-9f12-47ad-8999-54ec21d06664	f	f	TERMS_AND_CONDITIONS	20
6f212959-5692-4f15-b394-f75313a32ce3	delete_account	Delete Account	2fc07f5a-9f12-47ad-8999-54ec21d06664	f	f	delete_account	60
343c283f-b65f-4222-8c01-84fa2045f3fe	delete_credential	Delete Credential	2fc07f5a-9f12-47ad-8999-54ec21d06664	t	f	delete_credential	100
b8044ce5-641f-4784-a92c-29d91386314b	update_user_locale	Update User Locale	2fc07f5a-9f12-47ad-8999-54ec21d06664	t	f	update_user_locale	1000
c686b76d-f8aa-4bc7-b183-c0b1e39617b1	webauthn-register	Webauthn Register	2fc07f5a-9f12-47ad-8999-54ec21d06664	t	f	webauthn-register	70
79043b1f-0bf0-42b1-94f0-8295e06fa400	webauthn-register-passwordless	Webauthn Register Passwordless	2fc07f5a-9f12-47ad-8999-54ec21d06664	t	f	webauthn-register-passwordless	80
b2cc32bf-e1b3-4ee8-862e-251acaf06ffe	VERIFY_PROFILE	Verify Profile	2fc07f5a-9f12-47ad-8999-54ec21d06664	t	f	VERIFY_PROFILE	90
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
dda90977-935d-46a5-9869-cf36a2ef0e96	0b92ba2c-1cb0-4095-89b9-7f5ef37f77d2
dda90977-935d-46a5-9869-cf36a2ef0e96	575ba2c8-c8fd-4da8-8e2e-7547402d7fe0
da27507b-edfa-44f4-a2f0-a94225bea092	6c76e76c-e39a-4a0e-8de9-31d550459f27
da27507b-edfa-44f4-a2f0-a94225bea092	db63010b-1fda-413c-8687-ea8592481f6d
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_attribute (name, value, user_id, id, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
615cde69-10db-466f-b499-38b6f064a958	\N	7977dbe5-ea8e-493e-b67c-e8989876e875	f	t	\N	\N	\N	50f476a7-f350-43ba-8b98-a206554bea56	admin	1755077819182	\N	0
f8298003-4b6f-4c44-8c6c-9c133b6a3c9f	dev@local	dev@local	t	t	\N	Dev	Local	2fc07f5a-9f12-47ad-8999-54ec21d06664	dev	\N	\N	0
cd872f66-979d-42e9-8df7-a6ff27d1c717	emmanuelanicet.pro@gmail.com	emmanuelanicet.pro@gmail.com	f	t	\N	Emmanuel	Anicet	2fc07f5a-9f12-47ad-8999-54ec21d06664	m.anicet	1755096080506	\N	0
4b7b3cbb-d0b4-48e6-a4fb-ad8087ea623c	user@user	user@user	f	t	\N	First	User	2fc07f5a-9f12-47ad-8999-54ec21d06664	first.user	1755097031444	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
5d328112-bb96-418c-ae0f-d20a8b1be8ec	f8298003-4b6f-4c44-8c6c-9c133b6a3c9f
d7377a63-8105-4783-99da-3f29ecaeb17c	cd872f66-979d-42e9-8df7-a6ff27d1c717
92681d74-4b36-499f-a2a8-781472932ca8	4b7b3cbb-d0b4-48e6-a4fb-ad8087ea623c
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
b093f3d7-7842-4d76-b4df-af8ec109efd7	615cde69-10db-466f-b499-38b6f064a958
9ecdfdaf-13a3-4ab6-9178-fa556991f4ba	615cde69-10db-466f-b499-38b6f064a958
10eb566d-5b54-4db5-869c-46efa488e06c	f8298003-4b6f-4c44-8c6c-9c133b6a3c9f
c73e7344-f522-4b7b-bdad-63246570c1b0	f8298003-4b6f-4c44-8c6c-9c133b6a3c9f
2da24d08-a639-4ab2-a3b9-f112a7189a9a	f8298003-4b6f-4c44-8c6c-9c133b6a3c9f
58176dd8-8a8f-4a79-9f90-995c49479fd8	f8298003-4b6f-4c44-8c6c-9c133b6a3c9f
6ab9d722-870f-4f5c-a9bb-883000516ba6	f8298003-4b6f-4c44-8c6c-9c133b6a3c9f
6c76e76c-e39a-4a0e-8de9-31d550459f27	f8298003-4b6f-4c44-8c6c-9c133b6a3c9f
a1eaf1b5-7806-42e1-9df7-5708054d8ac1	f8298003-4b6f-4c44-8c6c-9c133b6a3c9f
e25f480b-7585-45c7-8638-55b4454518d8	f8298003-4b6f-4c44-8c6c-9c133b6a3c9f
1270a311-43e4-452c-b9b4-f5a6172274e4	f8298003-4b6f-4c44-8c6c-9c133b6a3c9f
aadade80-b23a-4f06-9ddb-4ddf3dc41233	f8298003-4b6f-4c44-8c6c-9c133b6a3c9f
db63010b-1fda-413c-8687-ea8592481f6d	f8298003-4b6f-4c44-8c6c-9c133b6a3c9f
3dd1ca0c-a8dd-4305-bf93-1cb5072ed000	f8298003-4b6f-4c44-8c6c-9c133b6a3c9f
e36d7da9-f221-42bd-997d-13bcf9952627	f8298003-4b6f-4c44-8c6c-9c133b6a3c9f
7c0bae9c-a70d-4fac-8dbb-ee9be899e481	f8298003-4b6f-4c44-8c6c-9c133b6a3c9f
f781624a-0d6d-416e-b697-5fa0cf347a2b	cd872f66-979d-42e9-8df7-a6ff27d1c717
db63010b-1fda-413c-8687-ea8592481f6d	cd872f66-979d-42e9-8df7-a6ff27d1c717
2da24d08-a639-4ab2-a3b9-f112a7189a9a	cd872f66-979d-42e9-8df7-a6ff27d1c717
f781624a-0d6d-416e-b697-5fa0cf347a2b	4b7b3cbb-d0b4-48e6-a4fb-ad8087ea623c
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.web_origins (client_id, value) FROM stdin;
88de62f1-8110-4f86-95b6-fb4df82ef163	+
faf611cc-6822-4e45-a870-a0b9360b785c	+
11ada4c6-3523-4a02-a7cf-2c3f06c7e176	+
c123e002-011b-4645-ab5a-10d4b9929eff	+
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: org_domain ORG_DOMAIN_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org_domain
    ADD CONSTRAINT "ORG_DOMAIN_pkey" PRIMARY KEY (id, name);


--
-- Name: org ORG_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT "ORG_pkey" PRIMARY KEY (id);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: user_consent uk_external_consent; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_external_consent UNIQUE (client_storage_provider, external_client_id, user_id);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_local_consent; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_local_consent UNIQUE (client_id, user_id);


--
-- Name: org uk_org_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_group UNIQUE (group_id);


--
-- Name: org uk_org_name; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_name UNIQUE (realm_id, name);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_uss_by_broker_session_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_broker_session_id ON public.offline_user_session USING btree (broker_session_id, realm_id);


--
-- Name: idx_offline_uss_by_last_session_refresh; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_last_session_refresh ON public.offline_user_session USING btree (realm_id, offline_flag, last_session_refresh);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_perm_ticket_owner; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_perm_ticket_owner ON public.resource_server_perm_ticket USING btree (owner);


--
-- Name: idx_perm_ticket_requester; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_perm_ticket_requester ON public.resource_server_perm_ticket USING btree (requester);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_usconsent_scope_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usconsent_scope_id ON public.user_consent_client_scope USING btree (scope_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--


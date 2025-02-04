CREATE TABLE public.admob_logs (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    app_version text,
    platform text,
    event_type text,
    message text,
    error text,
    ad_unit_id text,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now())
);


CREATE TABLE public.analyze_logs (
    id integer NOT NULL,
    user_id uuid,
    "timestamp" timestamp with time zone NOT NULL,
    result_type character varying(50) NOT NULL,
    make character varying(100),
    model character varying(100),
    phase character varying(50),
    series character varying(100),
    computer_elements text[],
    raw_response text,
    error_message text,
    analysis_time_ms integer,
    image_hash character varying(64),
    confidence_score double precision,
    detected_elements text[],
    success boolean,
    has_computer_elements boolean,
    created_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.auth_logs (
    id integer NOT NULL,
    event_type text NOT NULL,
    user_id text,
    details jsonb,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE public.brands (
    id bigint NOT NULL,
    name text NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    country text
);

CREATE TABLE public.conversation_members (
    conversation_id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()),
    last_read_at timestamp with time zone DEFAULT timezone('utc'::text, now())
);

CREATE TABLE public.conversations (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()),
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now())
);

CREATE TABLE public.follows (
    follower_id uuid NOT NULL,
    followed_id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now())
);

CREATE TABLE public.log_maintenance (
    id integer NOT NULL,
    is_maintenance boolean NOT NULL,
    changed_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE public.maintenance (
    id integer NOT NULL,
    is_maintenance boolean DEFAULT false NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE public.messages (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    sender_id uuid,
    receiver_id uuid,
    content text NOT NULL,
    is_read boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    conversation_id uuid
);

CREATE TABLE public.models (
    id bigint NOT NULL,
    brand_id bigint,
    name text NOT NULL,
    price numeric(10,2),
    engine text,
    horsepower integer,
    torque integer,
    curb_weight integer,
    acceleration_0_100 numeric(4,2),
    top_speed integer,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    phase character varying(50),
    series character varying(100),
    commercial_start_date text,
    commercial_end_date text,
    generation_name character varying(50),
    micro_history text,
    length numeric(4,2),
    width numeric(4,2),
    height numeric(4,2),
    trunk_volume_min integer,
    trunk_volume_max integer,
    doors integer,
    seats integer,
    engine_type character varying(50),
    fiscal_power integer,
    engine_description text,
    displacement integer,
    horsepower_rpm integer,
    transmission character varying(50),
    transmission_gears integer,
    drivetrain character varying(5),
    fuel_consumption_avg numeric(5,2),
    fuel_tank_capacity integer,
    co2_emission numeric(5,2),
    brake_type character varying(100),
    "trim" character varying(50),
    variant character varying(50),
    rarity character varying(20) DEFAULT 'common'::character varying NOT NULL,
    production_count integer,
    CONSTRAINT rarity_check CHECK (((rarity)::text = ANY ((ARRAY['common'::character varying, 'uncommon'::character varying, 'rare'::character varying, 'very_rare'::character varying, 'mythic'::character varying, 'legendary'::character varying])::text[])))
);

CREATE TABLE public.notification_tokens (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    user_id uuid,
    token text NOT NULL,
    device_type text NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);

CREATE TABLE public.notification_translations (
    notification_type character varying NOT NULL,
    language character varying NOT NULL,
    title text NOT NULL,
    body_template text NOT NULL
);

CREATE TABLE public.notifications (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    type text NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    seen boolean DEFAULT false NOT NULL,
    actor_id uuid,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()),
    data jsonb,
    push boolean DEFAULT true NOT NULL
);

CREATE TABLE public.profiles (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    username text,
    first_name text,
    last_name text,
    avatar_url text,
    phone text,
    bio text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    followers_count integer DEFAULT 0,
    following_count integer DEFAULT 0,
    language text,
    location_privacy boolean DEFAULT false NOT NULL,
    auto_save_photo boolean DEFAULT false,
    auto_publish_spot boolean DEFAULT true NOT NULL,
    premium_status boolean DEFAULT false,
    expo_push_token text,
    superspot_mode boolean DEFAULT false,
    current_streak integer DEFAULT 0,
    last_spot_date date,
    longest_streak integer DEFAULT 0
);

CREATE TABLE public.spot_comments (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    user_id uuid,
    spot_id uuid,
    content text NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.spot_likes (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    user_id uuid,
    spot_id uuid,
    created_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.spot_reports (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    user_id uuid NOT NULL,
    spot_id uuid NOT NULL,
    reason text NOT NULL,
    comment text
);

CREATE TABLE public.spot_shares (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    user_id uuid,
    spot_id uuid,
    created_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.update_checks (
    id bigint NOT NULL,
    current_version text NOT NULL,
    latest_version text NOT NULL,
    platform text NOT NULL,
    device_info jsonb,
    checked_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);

CREATE TABLE public.user_collections (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    user_id uuid,
    model_id bigint,
    spotted boolean DEFAULT false,
    spotted_date timestamp with time zone,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()),
    location text,
    latitude double precision,
    longitude double precision,
    image_url text,
    is_public boolean DEFAULT true,
    image2_url text,
    image3_url text,
    superspot boolean DEFAULT false,
    warn integer DEFAULT 0
);

CREATE TABLE public.versions (
    id bigint NOT NULL,
    version text NOT NULL,
    platform text NOT NULL,
    force_update boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    effective_date timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    CONSTRAINT versions_platform_check CHECK ((platform = ANY (ARRAY['ios'::text, 'android'::text])))
);
import { zod } from '../../../public/node/schema.js';
/**
 * The schema represents an Identity token.
 */
declare const IdentityTokenSchema: zod.ZodObject<{
    accessToken: zod.ZodString;
    refreshToken: zod.ZodString;
    expiresAt: zod.ZodEffects<zod.ZodDate, Date, unknown>;
    scopes: zod.ZodArray<zod.ZodString, "many">;
}, "strip", zod.ZodTypeAny, {
    accessToken: string;
    scopes: string[];
    refreshToken: string;
    expiresAt: Date;
}, {
    accessToken: string;
    scopes: string[];
    refreshToken: string;
    expiresAt?: unknown;
}>;
/**
 * The schema represents an application token.
 */
declare const ApplicationTokenSchema: zod.ZodObject<{
    accessToken: zod.ZodString;
    expiresAt: zod.ZodEffects<zod.ZodDate, Date, unknown>;
    scopes: zod.ZodArray<zod.ZodString, "many">;
}, "strip", zod.ZodTypeAny, {
    accessToken: string;
    scopes: string[];
    expiresAt: Date;
}, {
    accessToken: string;
    scopes: string[];
    expiresAt?: unknown;
}>;
/**
 * This schema represents the format of the session
 * that we cache in the system to avoid unnecessary
 * token exchanges.
 *
 * @example
 * ```
 * {
 *    "accounts.shopify.com": {
 *      "identity": {...} // IdentityTokenSchema
 *      "applications": {
 *        "${domain}-application-id": {  // Admin APIs includes domain in the key
 *          "accessToken": "...",
 *        },
 *        "$application-id": { // ApplicationTokenSchema
 *          "accessToken": "...",
 *        },
 *      }
 *    },
 *    "identity.spin.com": {...}
 * }
 * ```
 */
export declare const SessionSchema: zod.ZodObject<{}, "strip", zod.ZodObject<{
    /**
     * It contains the identity token. Before usint it, we exchange it
     * to get a token that we can use with different applications. The exchanged
     * tokens for the applications are stored under applications.
     */
    identity: zod.ZodObject<{
        accessToken: zod.ZodString;
        refreshToken: zod.ZodString;
        expiresAt: zod.ZodEffects<zod.ZodDate, Date, unknown>;
        scopes: zod.ZodArray<zod.ZodString, "many">;
    }, "strip", zod.ZodTypeAny, {
        accessToken: string;
        scopes: string[];
        refreshToken: string;
        expiresAt: Date;
    }, {
        accessToken: string;
        scopes: string[];
        refreshToken: string;
        expiresAt?: unknown;
    }>;
    /**
     * It contains exchanged tokens for the applications the CLI
     * authenticates with. Tokens are scoped under the fqdn of the applications.
     */
    applications: zod.ZodObject<{}, "strip", zod.ZodObject<{
        accessToken: zod.ZodString;
        expiresAt: zod.ZodEffects<zod.ZodDate, Date, unknown>;
        scopes: zod.ZodArray<zod.ZodString, "many">;
    }, "strip", zod.ZodTypeAny, {
        accessToken: string;
        scopes: string[];
        expiresAt: Date;
    }, {
        accessToken: string;
        scopes: string[];
        expiresAt?: unknown;
    }>, zod.objectOutputType<{}, zod.ZodObject<{
        accessToken: zod.ZodString;
        expiresAt: zod.ZodEffects<zod.ZodDate, Date, unknown>;
        scopes: zod.ZodArray<zod.ZodString, "many">;
    }, "strip", zod.ZodTypeAny, {
        accessToken: string;
        scopes: string[];
        expiresAt: Date;
    }, {
        accessToken: string;
        scopes: string[];
        expiresAt?: unknown;
    }>, "strip">, zod.objectInputType<{}, zod.ZodObject<{
        accessToken: zod.ZodString;
        expiresAt: zod.ZodEffects<zod.ZodDate, Date, unknown>;
        scopes: zod.ZodArray<zod.ZodString, "many">;
    }, "strip", zod.ZodTypeAny, {
        accessToken: string;
        scopes: string[];
        expiresAt: Date;
    }, {
        accessToken: string;
        scopes: string[];
        expiresAt?: unknown;
    }>, "strip">>;
}, "strip", zod.ZodTypeAny, {
    identity: {
        accessToken: string;
        scopes: string[];
        refreshToken: string;
        expiresAt: Date;
    };
    applications: {} & {
        [k: string]: {
            accessToken: string;
            scopes: string[];
            expiresAt: Date;
        };
    };
}, {
    identity: {
        accessToken: string;
        scopes: string[];
        refreshToken: string;
        expiresAt?: unknown;
    };
    applications: {} & {
        [k: string]: {
            accessToken: string;
            scopes: string[];
            expiresAt?: unknown;
        };
    };
}>, zod.objectOutputType<{}, zod.ZodObject<{
    /**
     * It contains the identity token. Before usint it, we exchange it
     * to get a token that we can use with different applications. The exchanged
     * tokens for the applications are stored under applications.
     */
    identity: zod.ZodObject<{
        accessToken: zod.ZodString;
        refreshToken: zod.ZodString;
        expiresAt: zod.ZodEffects<zod.ZodDate, Date, unknown>;
        scopes: zod.ZodArray<zod.ZodString, "many">;
    }, "strip", zod.ZodTypeAny, {
        accessToken: string;
        scopes: string[];
        refreshToken: string;
        expiresAt: Date;
    }, {
        accessToken: string;
        scopes: string[];
        refreshToken: string;
        expiresAt?: unknown;
    }>;
    /**
     * It contains exchanged tokens for the applications the CLI
     * authenticates with. Tokens are scoped under the fqdn of the applications.
     */
    applications: zod.ZodObject<{}, "strip", zod.ZodObject<{
        accessToken: zod.ZodString;
        expiresAt: zod.ZodEffects<zod.ZodDate, Date, unknown>;
        scopes: zod.ZodArray<zod.ZodString, "many">;
    }, "strip", zod.ZodTypeAny, {
        accessToken: string;
        scopes: string[];
        expiresAt: Date;
    }, {
        accessToken: string;
        scopes: string[];
        expiresAt?: unknown;
    }>, zod.objectOutputType<{}, zod.ZodObject<{
        accessToken: zod.ZodString;
        expiresAt: zod.ZodEffects<zod.ZodDate, Date, unknown>;
        scopes: zod.ZodArray<zod.ZodString, "many">;
    }, "strip", zod.ZodTypeAny, {
        accessToken: string;
        scopes: string[];
        expiresAt: Date;
    }, {
        accessToken: string;
        scopes: string[];
        expiresAt?: unknown;
    }>, "strip">, zod.objectInputType<{}, zod.ZodObject<{
        accessToken: zod.ZodString;
        expiresAt: zod.ZodEffects<zod.ZodDate, Date, unknown>;
        scopes: zod.ZodArray<zod.ZodString, "many">;
    }, "strip", zod.ZodTypeAny, {
        accessToken: string;
        scopes: string[];
        expiresAt: Date;
    }, {
        accessToken: string;
        scopes: string[];
        expiresAt?: unknown;
    }>, "strip">>;
}, "strip", zod.ZodTypeAny, {
    identity: {
        accessToken: string;
        scopes: string[];
        refreshToken: string;
        expiresAt: Date;
    };
    applications: {} & {
        [k: string]: {
            accessToken: string;
            scopes: string[];
            expiresAt: Date;
        };
    };
}, {
    identity: {
        accessToken: string;
        scopes: string[];
        refreshToken: string;
        expiresAt?: unknown;
    };
    applications: {} & {
        [k: string]: {
            accessToken: string;
            scopes: string[];
            expiresAt?: unknown;
        };
    };
}>, "strip">, zod.objectInputType<{}, zod.ZodObject<{
    /**
     * It contains the identity token. Before usint it, we exchange it
     * to get a token that we can use with different applications. The exchanged
     * tokens for the applications are stored under applications.
     */
    identity: zod.ZodObject<{
        accessToken: zod.ZodString;
        refreshToken: zod.ZodString;
        expiresAt: zod.ZodEffects<zod.ZodDate, Date, unknown>;
        scopes: zod.ZodArray<zod.ZodString, "many">;
    }, "strip", zod.ZodTypeAny, {
        accessToken: string;
        scopes: string[];
        refreshToken: string;
        expiresAt: Date;
    }, {
        accessToken: string;
        scopes: string[];
        refreshToken: string;
        expiresAt?: unknown;
    }>;
    /**
     * It contains exchanged tokens for the applications the CLI
     * authenticates with. Tokens are scoped under the fqdn of the applications.
     */
    applications: zod.ZodObject<{}, "strip", zod.ZodObject<{
        accessToken: zod.ZodString;
        expiresAt: zod.ZodEffects<zod.ZodDate, Date, unknown>;
        scopes: zod.ZodArray<zod.ZodString, "many">;
    }, "strip", zod.ZodTypeAny, {
        accessToken: string;
        scopes: string[];
        expiresAt: Date;
    }, {
        accessToken: string;
        scopes: string[];
        expiresAt?: unknown;
    }>, zod.objectOutputType<{}, zod.ZodObject<{
        accessToken: zod.ZodString;
        expiresAt: zod.ZodEffects<zod.ZodDate, Date, unknown>;
        scopes: zod.ZodArray<zod.ZodString, "many">;
    }, "strip", zod.ZodTypeAny, {
        accessToken: string;
        scopes: string[];
        expiresAt: Date;
    }, {
        accessToken: string;
        scopes: string[];
        expiresAt?: unknown;
    }>, "strip">, zod.objectInputType<{}, zod.ZodObject<{
        accessToken: zod.ZodString;
        expiresAt: zod.ZodEffects<zod.ZodDate, Date, unknown>;
        scopes: zod.ZodArray<zod.ZodString, "many">;
    }, "strip", zod.ZodTypeAny, {
        accessToken: string;
        scopes: string[];
        expiresAt: Date;
    }, {
        accessToken: string;
        scopes: string[];
        expiresAt?: unknown;
    }>, "strip">>;
}, "strip", zod.ZodTypeAny, {
    identity: {
        accessToken: string;
        scopes: string[];
        refreshToken: string;
        expiresAt: Date;
    };
    applications: {} & {
        [k: string]: {
            accessToken: string;
            scopes: string[];
            expiresAt: Date;
        };
    };
}, {
    identity: {
        accessToken: string;
        scopes: string[];
        refreshToken: string;
        expiresAt?: unknown;
    };
    applications: {} & {
        [k: string]: {
            accessToken: string;
            scopes: string[];
            expiresAt?: unknown;
        };
    };
}>, "strip">>;
export type Session = zod.infer<typeof SessionSchema>;
export type IdentityToken = zod.infer<typeof IdentityTokenSchema>;
export type ApplicationToken = zod.infer<typeof ApplicationTokenSchema>;
export {};

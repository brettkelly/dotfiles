/// <reference types="node" resolution-mode="require"/>
/**
 * It returns the environment variables of the environment
 * where the Node process is running.
 *
 * This function exists to prevent the access of the process
 * global variable which is discouraged via the no-process-env
 * ESLint rule.
 *
 * @returns Current process environment variables.
 */
export declare function getEnvironmentVariables(): NodeJS.ProcessEnv;
/**
 * Returns the value of the SHOPIFY_CLI_PARTNERS_TOKEN environment variable.
 *
 * @returns Current process environment variables.
 */
export declare function getPartnersToken(): string | undefined;
/**
 * Check if the current proccess is running using the partners token.
 *
 * @returns True if the current proccess is running using the partners token.
 */
export declare function usePartnersToken(): boolean;
/**
 * Returns the value of the organization id from the environment variables.
 *
 * @returns True if the current proccess is running using the partners token.
 */
export declare function getOrganization(): string | undefined;
/**
 * Return the backend port value.
 *
 * @returns The port as a number. Undefined otherwise.
 */
export declare function getBackendPort(): number | undefined;
/**
 * Returns the information of the identity token.
 *
 * @returns The identity token information in case it exists.
 */
export declare function getIdentityTokenInformation(): {
    accessToken: string;
    refreshToken: string;
} | undefined;

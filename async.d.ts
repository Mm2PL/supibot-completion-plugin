type ValidCallbackType = null | ((...a: any) => any);

export type RemoveCallbacks<
    T extends any[],
> = T extends [...infer Begin, any, any]
    ? Begin
    : T extends [any, any]
    ? []
    : never;

export type GetErrCallback<
    T extends any[],
> = T extends [...any, infer ErrorCallback extends ValidCallbackType]
    ? ErrorCallback
    : T extends [any, infer ErrorCallback extends ValidCallbackType]
    ? ErrorCallback
    : never;

export type GetOkCallback<
    T extends any[],
> = T extends [...any, infer OkCallback extends ValidCallbackType, any]
    ? OkCallback
    : T extends [infer OkCallback extends ValidCallbackType, any]
    ? OkCallback
    : never;

export type First<
    T extends [any, ...any],
> = T[0]

type ParametersNull<
    T extends ValidCallbackType
> = T extends ((...a: any) => any)
    ? Parameters<T>
    : [];

/**
 * Calls fun with arguments args, sets up callbacks and yields and will resume the coroutine whenever a callback from F is called.
 * If the error callback is called, error() will be called
 * @throws {GetErrCallback<F>}
 */
export declare function lawait<
    F extends (this: void, ...a: any) => any
>(this: void, fun: F, ...args: RemoveCallbacks<Parameters<F>>):
    ParametersNull<
        GetOkCallback<Parameters<F>>
    >;

/**
 * Executes F, suspends the current coroutine and will resume the coroutine whenever a callback from F is called.
 * If the error callback is called, this will return false and then the error
 */
export declare function plawait<
    F extends (this: void, ...a: any) => any
>(this: void, fun: F, ...args: RemoveCallbacks<Parameters<F>>):
    LuaMultiReturn<[true, ParametersNull<GetOkCallback<Parameters<F>>>]>
    | LuaMultiReturn<[false, ParametersNull<GetErrCallback<Parameters<F>>>]>;


export declare function asyncwrap<F extends Function>(fun: F): F;

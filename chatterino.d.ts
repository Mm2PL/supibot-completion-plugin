/** @noSelfInFile */

declare module c2 {
  enum LogLevel {
    Debug,
    Info,
    Warning,
    Critical,
  }
  enum CompletionType {
    Username,
    // emotes
    EmoteStart,
    FFZGlobalEmote,
    FFZChannelEmote,
    BTTVGlobalEmote,
    BTTVChannelEmote,
    SeventvGlobalEmote,
    SeventvChannelEmote,
    TwitchGlobalEmote,
    TwitchLocalEmote,
    TwitchSubscriberEmote,
    Emoji,
    EmoteEnd,
    // end emotes

    CustomCommand,
    ChatterinoCommand,
    TwitchCommand,
    PluginCommand,
    CustomCompletion,
  }

  type CompletionList = {
      values: Array<[string, CompletionType]>;
      done: boolean;
  }

  class CommandContext {
    words: string[];
    channel_name: string;
  }

  function log(level: LogLevel, ...data: any[]): void;
  function register_command(
    name: string,
    handler: (ctx: CommandContext) => void
  ): boolean;
  function send_msg(channel: string, text: string): boolean;
  function system_msg(channel: string, text: string): boolean;

  enum EventType {
    CompletionRequested,
  }

  type EventCallbackFunction =
      //Function
      ((this: void, text: string, prefix: string, is_first_word: boolean) => CompletionList);

  function register_callback(
    name: EventType,
    handler: EventCallbackFunction
  ): void;
}

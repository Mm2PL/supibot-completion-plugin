/** @noSelfInFile */

declare module c2 {
  enum LogLevel {
    Debug,
    Info,
    Warning,
    Critical,
  }

  type CompletionList = {
      values: string[];
      hide_others: boolean;
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
      ((this: void, prefix: string, full_text: string, position: number, is_first_word: boolean) => any);

  function register_callback(
    name: EventType,
    handler: EventCallbackFunction
  ): void;
}

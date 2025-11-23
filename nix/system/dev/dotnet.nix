{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dotnet-sdk_9
  ];
}



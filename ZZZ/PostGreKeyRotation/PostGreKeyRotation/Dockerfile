FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build-env
# Copy everything else and build
COPY . ./
WORKDIR PostGreKeyRotation/PostGreKeyRotation/
RUN dotnet restore
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR PostGreKeyRotation/PostGreKeyRotation/
EXPOSE 80
COPY --from=build-env PostGreKeyRotation/PostGreKeyRotation/out .
ENTRYPOINT ["dotnet", "PostGreKeyRotation.dll"]

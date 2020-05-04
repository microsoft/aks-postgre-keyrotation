# // Copyright (c) Microsoft Corporation.
# // Licensed under the MIT license.

FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build-env
# Copy everything else and build
COPY . ./
WORKDIR PostgreKeyRotation/PostgreKeyRotation/
RUN dotnet restore
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR PostgreKeyRotation/PostgreKeyRotation/
EXPOSE 80
COPY --from=build-env PostgreKeyRotation/PostgreKeyRotation/out .
ENTRYPOINT ["dotnet", "PostgreKeyRotation.dll"]

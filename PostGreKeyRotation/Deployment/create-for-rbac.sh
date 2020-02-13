#!/bin/bash

az ad sp create-for-rbac --name jwrotateakssp --role Contributor --scope /subscriptions/<subscription-id>

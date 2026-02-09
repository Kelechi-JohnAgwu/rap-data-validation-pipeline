# Reproducible Data Validation Pipeline (R)

A production-style R pipeline for validating administrative datasets, applying quality checks, and generating automated outputs (tables/reports/logs) in a reproducible way.

## Why this exists
This project demonstrates how to:
- run repeatable validation checks on structured data
- track issues clearly (what failed, why, where)
- produce consistent outputs and logs for auditability
- structure an R project like a production pipeline

## What it does (planned)
- Ingest: read input files from `data/raw/`
- Validate: schema checks, missingness, ranges, duplicates, date logic
- Transform: standardise fields and types
- Outputs: cleaned dataset + error report + summary tables

## Tech stack (planned)
- `targets` for orchestration
- `fs` / `here` for file management
- `validate` or custom rules for checks
- `openxlsx` for Excel outputs (optional)
- `testthat` for unit tests

## Project structure

## Getting started
Setup and usage instructions will be added as the pipeline is developed. 

## Project status
This project is currently under development.

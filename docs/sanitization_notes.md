# Sanitization Notes

This project is based on real-world data workflows but has been fully sanitized for public use.

The following adjustments were made to preserve confidentiality while maintaining the structure and logic of the pipeline:

## Data Sources
- Original data sources have been replaced with generic placeholders (e.g., `source_operational_data`)
- All references to internal systems, storage locations, and proprietary tables have been removed

## Naming Conventions
- Column and field names have been generalized to remove domain-specific or internal terminology
- Metric names have been simplified to reflect common analytical concepts (e.g., planned vs. actual comparisons)

## Business Logic
- Core transformations and calculations have been preserved
- Threshold values and alerting logic have been simplified to demonstrate methodology without exposing internal standards

## Removed Elements
- External storage paths and export logic
- System-specific identifiers and configurations
- Any references to internal tools or infrastructure

## Purpose
The goal of this project is to demonstrate ETL design, data transformation, and analytical thinking in a way that is transferable across industries while respecting data privacy and confidentiality.

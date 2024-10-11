#!/bin/bash

# Clear Hexo cache
echo "Clearing Hexo cache..."
hexo clean

# Generate static files
echo "Generating static files..."
hexo generate

# Copy index.html from source to public
echo "Copying index.html from source to public..."
cp source/index.html public/index.html

# Deploy the generated site
echo "Deploying the site..."
hexo deploy

# Success message
echo "Hexo deployment completed successfully!"

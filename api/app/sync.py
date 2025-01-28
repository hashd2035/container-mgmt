import requests

# Configure PocketBase
POCKETBASE_URL = "http://localhost:8090"
COLLECTION_CONTAINERS = "containers"
COLLECTION_IMAGES = "images"

def sync_containers(containers):
    for container in containers:
        data = {
            "id": container.id,
            "labels": container.labels,
            "status": container.status,
        }
        # Sync container data with PocketBase
        requests.post(f"{POCKETBASE_URL}/api/collections/{COLLECTION_CONTAINERS}/records", json=data)

def sync_images(images):
    for image in images:
        data = {
            "name": image.name,
            "size": image.size,
        }
        # Sync image data with PocketBase
        requests.post(f"{POCKETBASE_URL}/api/collections/{COLLECTION_IMAGES}/records", json=data)

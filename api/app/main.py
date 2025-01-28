from fastapi import FastAPI
from app.containerd import ContainerdClient
from app.sync import sync_containers, sync_images

app = FastAPI()
containerd_client = ContainerdClient()

@app.get("/containers")
def get_containers():
    containers = containerd_client.list_containers()
    sync_containers(containers)  # Sync with PocketBase
    return [{"id": c.id, "labels": c.labels, "status": c.status} for c in containers]

@app.get("/images")
def get_images():
    images = containerd_client.list_images()
    sync_images(images)  # Sync with PocketBase
    return [{"name": i.name, "size": i.size} for i in images]

import grpc
from containerd.services.containers.v1 import containers_pb2_grpc, containers_pb2
from containerd.services.images.v1 import images_pb2_grpc, images_pb2

class ContainerdClient:
    def __init__(self, socket_path="/run/containerd/containerd.sock"):
        self.channel = grpc.insecure_channel(socket_path)
        self.container_service = containers_pb2_grpc.ContainersStub(self.channel)
        self.image_service = images_pb2_grpc.ImagesStub(self.channel)

    def list_containers(self):
        request = containers_pb2.ListContainersRequest()
        response = self.container_service.List(request)
        return response.containers

    def list_images(self):
        request = images_pb2.ListImagesRequest()
        response = self.image_service.List(request)
        return response.images

using Amazon.S3;
using Amazon.S3.Model;
using Amazon.S3.Util;
using Common.Constant;
using Microsoft.AspNetCore.Http;
using SixLabors.ImageSharp;
using SixLabors.ImageSharp.PixelFormats;
using SixLabors.ImageSharp.Processing;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Common.Helpers;
using Microsoft.AspNetCore.Hosting;
using System.Net;
using Microsoft.Extensions.Hosting;
using System.Text;

namespace Common.Helpers
{
    public class AmazonS3Service
    {
        public static async Task<bool> UploadObject(IFormFile file, Image_Upload_Type type, string fileName)
        {
            // connecting to the client
            var client = new AmazonS3Client(Settings.AMAZONE_S3_ACCESS_KEY, Settings.AMAZONE_S3_SECRET_KEY, GetAmazonS3EndpointByFolderListingURL());

            // get the file and convert it to the byte[]
            byte[] fileBytes = new Byte[file.Length];
            file.OpenReadStream().Read(fileBytes, 0, Int32.Parse(file.Length.ToString()));

            PutObjectResponse response = null;

            using (var stream = new MemoryStream(fileBytes))
            {
                string bucketName = Settings.AMAZONE_S3_BUCKET_NAME;
                try
                {
                    Task<bool> checkExistBucket = AmazonS3Util.DoesS3BucketExistV2Async(client, bucketName);
                    if (!checkExistBucket.Result)
                    {
                        var bucket = new PutBucketRequest
                        {
                            BucketName = bucketName,
                            BucketRegion = S3Region.EUW2,
                            CannedACL = S3CannedACL.PublicRead
                        };
                        try
                        {
                            await client.PutBucketAsync(bucket);
                        }
                        catch (AmazonS3Exception e)
                        { }
                    }
                    var request = new PutObjectRequest
                    {
                        BucketName = bucketName,
                        InputStream = stream,
                        CannedACL = S3CannedACL.PublicRead
                    };

                    switch (type)
                    {
                        case Image_Upload_Type.Branch:
                            request.Key = Settings.AMAZONE_S3_BUCKET_BRANCHES + "/" + fileName;
                            break;
                        case Image_Upload_Type.Avatar_User:
                            request.Key = Settings.AMAZONE_S3_BUCKET_USER_AVATARS + "/" + fileName;
                            break;
                        case Image_Upload_Type.Sale_location:
                            request.Key = Settings.AMAZONE_S3_BUCKET_SALE_LOCATIONS + "/" + fileName;
                            break;
                        case Image_Upload_Type.Product:
                            request.Key = Settings.AMAZONE_S3_BUCKET_PRODUCTS + "/" + fileName;
                            break;
                        case Image_Upload_Type.Folder:
                            request.Key = Settings.AMAZONE_S3_BUCKET_FILES + "/" + fileName;
                            break;
                        case Image_Upload_Type.Stock:
                            request.Key = Settings.AMAZONE_S3_BUCKET_STOCKS + "/" + fileName;
                            break;
                        case Image_Upload_Type.DeviceVersion:
                            request.Key = Settings.AMAZONE_S3_BUCKET_DEVICE_VERSIONS + "/" + fileName;
                            break;
                        case Image_Upload_Type.ProductGroup:
                            request.Key = Settings.AMAZONE_S3_BUCKET_PRODUCTGROUP + "/" + fileName;
                            break;
                        case Image_Upload_Type.TicketingVenue:
                            request.Key = Settings.AMAZONE_S3_BUCKET_TICKETINGVENUE + "/" + fileName;
                            break;
                        default:
                            request.Key = Settings.AMAZONE_S3_BUCKET_DEFAULT + "/" + fileName;
                            break;
                    }
                    try
                    {
                        response = await client.PutObjectAsync(request);
                    }
                    catch (AmazonS3Exception e)
                    {

                    }
                }
                catch (Exception e) { }
            }
            ;

            return response?.HttpStatusCode == System.Net.HttpStatusCode.OK;
        }


        public static async Task<Dictionary<bool, string>> UploadLogFile(IFormFile file, string fileName)
        {
            // Init result
            var result = new Dictionary<bool, string>();
            // connecting to the client
            var client = new AmazonS3Client(Settings.AMAZONE_S3_ACCESS_KEY, Settings.AMAZONE_S3_SECRET_KEY, GetAmazonS3EndpointByFolderListingURL());

            // get the file and convert it to the byte[]
            byte[] fileBytes = new Byte[file.Length];
            file.OpenReadStream().Read(fileBytes, 0, Int32.Parse(file.Length.ToString()));


            using (var stream = new MemoryStream(fileBytes))
            {
                string bucketName = Settings.AMAZONE_S3_LOGS_BUCKET_NAME;

                bool checkExistBucket = await AmazonS3Util.DoesS3BucketExistV2Async(client, bucketName);
                if (!checkExistBucket)
                {
                    var bucket = new PutBucketRequest
                    {
                        BucketName = bucketName,
                        BucketRegion = S3Region.EUW2,
                        CannedACL = S3CannedACL.PublicRead
                    };
                    try
                    {
                        await client.PutBucketAsync(bucket);
                    }
                    catch (AmazonS3Exception e)
                    {
                        result.Add(false, e.Message);
                        return result;
                    }
                }
                var request = new PutObjectRequest
                {
                    BucketName = bucketName,
                    InputStream = stream,
                    Key = Settings.AMAZONE_S3_LOGS_FOLDER + "/" + fileName,
                };


                try
                {
                    var response = await client.PutObjectAsync(request);
                    if (response?.HttpStatusCode == HttpStatusCode.OK)
                    {
                        result.Add(true, string.Empty);
                    }
                }
                catch (AmazonS3Exception e)
                {
                    result.Add(false, e.Message);
                    return result;
                }
            }

            return result;
        }


        public static async Task<bool> UploadThumbnail(IFormFile image, Image_Upload_Type type, string fileName)
        {
            // connecting to the client
            var client = new AmazonS3Client(Settings.AMAZONE_S3_ACCESS_KEY, Settings.AMAZONE_S3_SECRET_KEY, GetAmazonS3EndpointByFolderListingURL());
            PutObjectResponse response = null;

            using (MemoryStream stream = new MemoryStream())
            {
                // get the file and convert it to the byte[]
                byte[] fileBytes = new byte[image.Length];
                image.OpenReadStream().Read(fileBytes, 0, Int32.Parse(image.Length.ToString()));

                using (Image<Rgba32> imageRgba = (Image<Rgba32>)Image.Load(fileBytes))
                {
                    if (fileBytes.Length > Default_HandHeld_Image_Size.MAX_SIZE_THUMBNAIL)
                    {
                        int width = Default_HandHeld_Image_Size.Product_Size,
                            height = Default_HandHeld_Image_Size.Product_Size;
                        if (type == Image_Upload_Type.Sale_location)
                        {
                            width = Default_HandHeld_Image_Size.Sale_Location_Width;
                            height = Default_HandHeld_Image_Size.Sale_Location_Height;
                        }

                        imageRgba.Mutate(x => x
                            .Resize(new ResizeOptions()
                            {
                                Size = new Size(width, height),
                                Mode = ResizeMode.Max
                            })
                        );
                    }

                    if (fileName.Contains(".png"))
                    {
                        imageRgba.SaveAsPng(stream);
                    }
                    else if (fileName.Contains(".gif"))
                    {
                        imageRgba.SaveAsGif(stream);
                    }
                    else
                    {
                        imageRgba.SaveAsJpeg(stream);
                    }
                }

                var request = new PutObjectRequest
                {
                    BucketName = Settings.AMAZONE_S3_BUCKET_NAME,
                    InputStream = stream,
                    CannedACL = S3CannedACL.PublicRead
                };

                switch (type)
                {
                    case Image_Upload_Type.Branch:
                        request.Key = Settings.AMAZONE_S3_BUCKET_BRANCHES + "/" + fileName;
                        break;
                    case Image_Upload_Type.Avatar_User:
                        request.Key = Settings.AMAZONE_S3_BUCKET_USER_AVATARS + "/" + fileName;
                        break;
                    case Image_Upload_Type.Sale_location:
                        request.Key = Settings.AMAZONE_S3_BUCKET_SALE_LOCATIONS + "/" + fileName;
                        break;
                    case Image_Upload_Type.Product:
                        request.Key = Settings.AMAZONE_S3_BUCKET_PRODUCTS + "/" + fileName;
                        break;
                    case Image_Upload_Type.Folder:
                        request.Key = Settings.AMAZONE_S3_BUCKET_FILES + "/" + fileName;
                        break;
                    case Image_Upload_Type.Stock:
                        request.Key = Settings.AMAZONE_S3_BUCKET_STOCKS + "/" + fileName;
                        break;
                    case Image_Upload_Type.DeviceVersion:
                        request.Key = Settings.AMAZONE_S3_BUCKET_DEVICE_VERSIONS + "/" + fileName;
                        break;
                    case Image_Upload_Type.ProductGroup:
                        request.Key = Settings.AMAZONE_S3_BUCKET_PRODUCTGROUP + "/" + fileName;
                        break;
                    case Image_Upload_Type.TicketingVenue:
                        request.Key = Settings.AMAZONE_S3_BUCKET_TICKETINGVENUE + "/" + fileName;
                        break;
                    default:
                        request.Key = Settings.AMAZONE_S3_BUCKET_DEFAULT + "/" + fileName;
                        break;
                }
                try
                {
                    response = await client.PutObjectAsync(request);
                }
                catch (AmazonS3Exception e)
                {

                }
            }

            return response?.HttpStatusCode == System.Net.HttpStatusCode.OK;
        }

        public static async Task<Dictionary<bool, string>> RemoveObject(string fileName)
        {
            // Init result
            var result = new Dictionary<bool, string>();

            var client = new AmazonS3Client(Settings.AMAZONE_S3_ACCESS_KEY, Settings.AMAZONE_S3_SECRET_KEY, new AmazonS3Config() { ServiceURL = $"https://{Settings.AMAZONE_S3_FOLDER_LISTING_URL}" });

            var request = new DeleteObjectRequest
            {
                BucketName = Settings.AMAZONE_S3_BUCKET_NAME,
                Key = fileName
            };

            try
            {
                var response = await client.DeleteObjectAsync(request);

                if (response != null)
                {
                    result.Add(true, string.Empty);
                }
                else
                {
                    result.Add(false, "Something went wrong.Please try again!");
                }
            }
            catch (AmazonS3Exception e)
            {
                result.Add(false, e.Message);
            }

            return result;
        }

        private static Amazon.RegionEndpoint GetAmazonS3EndpointByFolderListingURL()
        {
            string regionSetting = Settings.AMAZONE_S3_FOLDER_LISTING_URL.Split('.')[1].ToLower();
            foreach (var region in Amazon.RegionEndpoint.EnumerableAllRegions)
            {
                if (region.ToString().ToLower().Contains(regionSetting))
                {
                    return region;
                }
            }

            return null;
        }

        public static async Task<Dictionary<bool, string>> UploadImageThumbnail(IFormFile image, string path, string fileName)
        {
            // Init result
            var result = new Dictionary<bool, string>();
            // connecting to the client
            var client = new AmazonS3Client(Settings.AMAZONE_S3_ACCESS_KEY, Settings.AMAZONE_S3_SECRET_KEY, new AmazonS3Config() { ServiceURL = $"https://{Settings.AMAZONE_S3_FOLDER_LISTING_URL}" });
            PutObjectResponse response = null;

            using (MemoryStream stream = new MemoryStream())
            {
                // get the file and convert it to the byte[]
                byte[] fileBytes = new byte[image.Length];
                image.OpenReadStream().Read(fileBytes, 0, Int32.Parse(image.Length.ToString()));

                using (Image<Rgba32> imageRgba = (Image<Rgba32>)Image.Load(fileBytes))
                {
                    if (fileName.Contains(".png"))
                    {
                        imageRgba.SaveAsPng(stream);
                    }
                    else if (fileName.Contains(".gif"))
                    {
                        imageRgba.SaveAsGif(stream);
                    }
                    else
                    {
                        imageRgba.SaveAsJpeg(stream);
                    }
                }

                var request = new PutObjectRequest
                {
                    BucketName = Settings.AMAZONE_S3_BUCKET_NAME,
                    InputStream = stream,
                    CannedACL = S3CannedACL.PublicRead,
                    Key = path + fileName
                };

                try
                {
                    response = await client.PutObjectAsync(request);
                    if (response != null && response.HttpStatusCode == System.Net.HttpStatusCode.OK)
                    {
                        result.Add(true, response.ETag);
                    }
                    else
                    {
                        result.Add(false, "Something went wrong.Please try again!");
                    }
                }
                catch (AmazonS3Exception e)
                {
                    result.Add(false, e.Message);
                    return result;
                }
            }

            return result;
        }

        public static string GetImageAsBase64(IHostEnvironment environment, string imagePath)
        {
            if (!string.IsNullOrEmpty(imagePath))
            {
                //if (imagePath.Contains(Settings.AMAZONE_S3_FOLDER_LISTING_URL))
                //{
                using (WebClient client = new WebClient())
                {
                    string filename = Path.GetFileName(imagePath);
                    string thumnailPath = imagePath.Replace(filename, $"{GlobalConstant.THUMBNAIL_PREFIX}{filename}");

                    try
                    {
                        byte[] bytes = client.DownloadData(thumnailPath);
                        return Convert.ToBase64String(bytes);
                    }
                    catch (Exception)
                    {
                        return string.Empty;
                    }

                }
                //}
                //else
                //{
                //	string rootPath = environment.WebRootPath;

                //	if (string.IsNullOrEmpty(rootPath))
                //	{
                //		rootPath = environment.ContentRootPath + "\\wwwroot";
                //	}

                //	imagePath = Path.Combine(rootPath, imagePath);
                //	string thumbnailPath = imagePath.Replace(FILE_PATH.IMAGE_APART_PATH, FILE_PATH.THUMBNAIL_APART_PATH);
                //	string fileName = Path.GetFileName(imagePath);

                //	if (File.Exists(imagePath))
                //	{
                //		if (!File.Exists(thumbnailPath))
                //		{
                //			return ImageToBase64(ResizeImage(imagePath, thumbnailPath), fileName);
                //		}

                //		using (var image = Image.Load(thumbnailPath))
                //		{
                //			return ImageToBase64(image, fileName);
                //		}
                //	}

                //}
            }

            return string.Empty;
        }
    }
}

import numpy as np
import dnnlib, argparse, pickle, imageio, os
import dnnlib.tflib as tflib
import torch
from PIL import Image

# Take input arguments
parser = argparse.ArgumentParser()
parser.add_argument('--input', help='Latent vector folder', type=str, dest='input', required=True)
parser.add_argument('--style', help='Target mix', type=str, dest='style', required=True)
parser.add_argument('--output', help='Output image file', type=str, dest='output', required=True)
parser.add_argument('--net', help='Network .pkl name', type=str, dest='net', default='ffhq')
args = parser.parse_args()

styleVector = np.load(args.style)['dlatents']

frameFiles = sorted(os.listdir(args.input))

device = torch.device('cuda')
with dnnlib.util.open_url(f'pretrained/{args.net}.pkl') as fp:
    _G, _D, Gs = pickle.load(fp)
    fp.close()

writer = imageio.get_writer(f'{args.output}.mp4', mode='I', fps=25, codec='libx264', bitrate='16M')

# Run projector.
mix = np.linspace(0,1,len(frameFiles))
for idx, file in enumerate(frameFiles):
    targetVector = np.load(f"{args.input}/{file}")['dlatents']
    if idx < len(frameFiles)/2:
        w_new = targetVector*2*mix[idx]+styleVector*(1-2*mix[idx])
    else:
        w_new = targetVector*(1-2*mix[idx])+styleVector*2*mix[idx]
    image = Gs.components.synthesis.run(w_new, output_transform=dict(func=tflib.convert_images_to_uint8, nchw_to_nhwc=True))[0]
    writer.append_data(image)

writer.close()

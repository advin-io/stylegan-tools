import numpy as np
import dnnlib, argparse, pickle, imageio
import dnnlib.tflib as tflib
from PIL import Image

parser = argparse.ArgumentParser()
parser.add_argument('--first', help='First latent vector', type=str, dest='firstdlatents', required=True)
parser.add_argument('--second', help='Second latent vector', type=str, dest='seconddlatents', required=True)
parser.add_argument('--output', help='Output image file', type=str, dest='output', required=True)
parser.add_argument('--net', help='Network .pkl name', type=str, dest='net', default='ffhq')
parser.add_argument('--mix', help='Percentage of first image to blend with second', type=float, dest='mix', default=0.0)
args = parser.parse_args()

first_vector = np.load(args.firstdlatents)['dlatents']
second_vector = np.load(args.seconddlatents)['dlatents']

dnnlib.tflib.init_tf()
with dnnlib.util.open_url(f'pretrained/{args.net}.pkl') as fp:
    _G, _D, Gs = pickle.load(fp)
    fp.close()


if args.mix > 0:
    w_new = first_vector*args.mix+second_vector*(1-args.mix)
    image = Gs.components.synthesis.run(w_new, output_transform=dict(func=tflib.convert_images_to_uint8, nchw_to_nhwc=True))[0]
    im = Image.fromarray(image)
    im.save(args.output)
else:
    writer = imageio.get_writer(f'{args.output}.mp4', mode='I', fps=60, codec='libx264', bitrate='16M')

    # Run projector.
    mix = np.linspace(0,1,300)
    for idx in range(len(mix)):
        w_new = first_vector*mix[idx]+second_vector*(1-mix[idx])
        image = Gs.components.synthesis.run(w_new, output_transform=dict(func=tflib.convert_images_to_uint8, nchw_to_nhwc=True))[0]
        writer.append_data(image)

    writer.close()


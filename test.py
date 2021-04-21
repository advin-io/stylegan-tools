import pickle, legacy, torch, numpy

device = torch.device('cuda')
# Open the file in binary mode
with open('pretrained/ffhq.pkl', 'rb') as file:
    
    # Call load method to deserialze
    G = legacy.load_network_pkl(file)['G_ema'].to(device) # type: ignore
  
    print(G.mapping())

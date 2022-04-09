# Copyright 2022 XXIV
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
import httpClient
import os
import dogapi
import strutils

const DIR = "images"

proc usage() =
  echo "Usage: dogapi -r"
  echo "           (Download random dog image)"
  echo "   or  dogapi -r [number]"
  echo "           (Download multiple random dog images)"
  echo "   or  dogapi -r --breed \"BREED_NAME\""
  echo "           (Download random dog image from the givien breed)"
  echo "   or  dogapi -r --breed \"BREED_NAME\" [number]"
  echo "           (Download multiple random dog images from the givien breed)"
  echo "   or  dogapi --breed \"BREED_NAME\""
  echo "           (Download all dog images from the givien breed)"
  echo "   or  dogapi -r --breed \"BREED_NAME\" --sub-breed \"SUB_BREED_NAME\""
  echo "           (Download random dog image from the givien sub breed)"
  echo "   or  dogapi -r --breed \"BREED_NAME\" --sub-breed \"SUB_BREED_NAME\" [number]"
  echo "           (Download multiple random dog images from the givien sub breed)"
  echo "   or  dogapi --breed \"BREED_NAME\" --sub-breed \"SUB_BREED_NAME\""
  echo "           (Download all dog images from the givien sub breed)"

proc fileName(url: string): string =
  let array = url.split("/")
  return array[array.len - 1]


proc download(url: string, dir: string) =
  let client = newHttpClient()
  client.downloadFile(url,dir & "/" & url.filename)
  client.close()


proc args(): seq[string] =
  var sequence: seq[string] = @[]
  for i in countup(1, paramCount()):
    sequence.add(paramStr(i))
  return sequence


proc indexExists(sequence: seq[string],index: int): bool =
  return index >= 0 and index < sequence.len


proc main() =
  try:
      if not dirExists(DIR):
        createDir(DIR)
      if not indexExists(args(), 0):
        usage()
      elif indexExists(args(), 0):
        if args()[0] == "-r":
          if not indexExists(args(),1):
            let image = randomImage()
            let dir = DIR & "/" & "random"
            if not dirExists(dir):
              createDir(dir)
            image.download(dir)
            echo "Downloaded"
          elif indexExists(args(),1):
            if args()[1] != "--breed":
              var number = 0
              try:
                number = parseInt(args()[1])
              except:
                echo "Error: ", args()[1], " is not a valid number"
                quit(1)
              let images = multipleRandomImages(number)
              let dir = DIR & "/" & "random"
              if not dirExists(dir):
                createDir(dir)
              for dog in images:
                dog.download(dir)
              echo "Downloaded"
            else:
              if not indexExists(args(),2):
                echo "Error: missing breed name"
                quit(1)
              if not indexExists(args(),3):
                let image = randomImageByBreed(args()[2])
                let dir = DIR & "/" & args()[2]
                if not dirExists(dir):
                  createDir(dir)
                image.download(dir)
                echo "Downloaded"
              elif indexExists(args(),3):
                if args()[3] != "--sub-breed":
                  var number = 0
                  try:
                    number = parseInt(args()[3])
                  except:
                    echo "Error: ", args()[3], " is not a valid number"
                    quit(1)
                  let images = multipleRandomImagesByBreed(args()[2],number)
                  let dir = DIR & "/" & args()[2]
                  if not dirExists(dir):
                    createDir(dir)
                  for dog in images:
                    dog.download(dir)
                  echo "Downloaded"
                else:
                  if not indexExists(args(),4):
                    echo "Error: missing sub breed name"
                    quit(1)
                  if not indexExists(args(),5):
                    let image = randomImageBySubBreed(args()[2],args()[4])
                    let dir = DIR & "/" & args()[2] & "/" & args()[4]
                    let breedDir = DIR & "/" & args()[2]
                    if not dirExists(breedDir):
                      createDir(breedDir)
                    if not dirExists(dir):
                      createDir(dir)
                    image.download(dir)
                    echo "Downloaded"
                  elif indexExists(args(), 5):
                    var number = 0
                    try:
                      number = parseInt(args()[5])
                    except:
                      echo "Error: ", args()[5], " is not a valid number"
                      quit(1)
                    let images = multipleRandomImagesBySubBreed(args()[2],args()[4], number)
                    let dir = DIR & "/" & args()[2] & "/" & args()[4]
                    let breedDir = DIR & "/" & args()[2]
                    if not dirExists(breedDir):
                      createDir(breedDir)
                    if not dirExists(dir):
                      createDir(dir)
                    for dog in images:
                      dog.download(dir)
                    echo "Downloaded"
        elif args()[0] == "--breed":
          if not indexExists(args(), 1):
            echo "Error: missing breed name"
            quit(1)
          if not indexExists(args(), 2):
            let images = imagesBybreed(args()[1])
            let dir = DIR & "/" & args()[1]
            if not dirExists(dir):
              createDir(dir)
            for dog in images:
              dog.download(dir)
            echo "Downloaded"
          elif indexExists(args(), 2):
            if args()[2] != "--sub-breed":
              echo "Error: unknown flag ", args()[2]
            else:
              if not indexExists(args(),3):
                echo "Error: missing sub breed name"
              else:
                let images = imagesBySubbreed(args()[1],args()[3])
                let dir = DIR & "/" & args()[1] & "/" & args()[3]
                let breedDir = DIR & "/" & args()[1]
                if not dirExists(breedDir):
                  createDir(breedDir)
                if not dirExists(dir):
                  createDir(dir)
                for dog in images:
                  dog.download(dir)
                echo "Downloaded"
        else:
          usage()
  except:
    echo "Error: ", getCurrentExceptionMsg()


when isMainModule:
  main()
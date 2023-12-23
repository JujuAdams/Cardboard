# Quick Start

&nbsp;

## Introduction

Cardboard is a 3D geometry and rendering library. It is not designed to be friendly for absolute beginners. Cardboard presumes you have some limited experience with graphics programming, including a basic understanding of z-writing and z-testing, vertex batches, textures, matrix transforms etc. There are a lot of convenience functions built into the library and many functions call other, lower level, functions. Documentation can only go so far to explain the specific mechanics of each feature and I encourage you to go under the hood to investigate how Cardboard is put together.

Cardboard is made out of two components: the "Build" component and the "Render" component. These two components are, in reality, sub-libraries and can operate independently of each other should you so wish. The solutions in both the Build component and the Render component are broadly applicable to 3D games.

The Build component concerns itself with constructing 3D geometry from sprites, surfaces, tiles, and GameMaker native particle effects. It allows for CPU-side billboarding and the construction of vertex buffer batches ("models"). Billboards can be build with normals and using a "double-sided" mode which draws both a front face and a back face to ease shadow map rendering.

The Render component concerns itself with drawing a 3D scene, including camera positioning, z-tilting, lighting and shadow mapping, fogging, and multi-pass rendering for alpha blending. The Render component can be operated in unlit, forward, or deferred rendering modes. Cardboard's rendering can be performed in addition to other draw procedures that you may be using, including any post-processing effects you might have.

If you'd like to know more about each individual part, you are welcome to explore documentation futher. But we're not here to get snarled up in technical details: let's build our first scene together.

&nbsp;

## Project Setup